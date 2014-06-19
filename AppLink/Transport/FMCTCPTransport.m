//  FMCTCPTransport.m
//  FMCSyncTcpTransport.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import "FMCTCPTransport.h"
#import "FMCDebugTool.h"
#import <errno.h>
#import <signal.h>
#import <stdio.h>
#import <unistd.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <sys/wait.h>
#import <netinet/in.h>
#import <netdb.h>

int call_socket(const char* hostname, const char* port) { 
    
    int status, sock;
    struct addrinfo hints;
    struct addrinfo* servinfo;
    
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    
    //no host name?, no problem, get local host
    if (hostname == nil){
        char localhost[128];
        gethostname(localhost, sizeof localhost);
        hostname = (const char*) &localhost;
    }
    
    //getaddrinfo setup
    if ((status = getaddrinfo(hostname, port, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(status));
        return(-1);
    }
    
    //get socket
    if ((sock = socket(servinfo->ai_family, servinfo->ai_socktype, servinfo->ai_protocol)) < 0)
		return(-1);
    
    //connect
    if (connect(sock, servinfo->ai_addr, servinfo->ai_addrlen) < 0) {
		close(sock);
		return(-1);
	}
    
    freeaddrinfo(servinfo); // free the linked-list
    return(sock);
} 

@implementation FMCTCPTransport

static void TCPCallback(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
	if (kCFSocketConnectCallBack == type) {
		FMCTCPTransport *transport = (FMCTCPTransport *)info;
		SInt32 errorNumber = 0;
		if (data) {
			SInt32 *errorNumberPtr = (SInt32 *)data;
			errorNumber = *errorNumberPtr;
		}
		[transport notifyTransportConnected];
	} else if (kCFSocketDataCallBack == type) {
		FMCTCPTransport *transport = (FMCTCPTransport *)info;
        
        NSMutableString* byteStr = [NSMutableString stringWithCapacity:((int)CFDataGetLength((CFDataRef)data) * 2)];
        for (int i = 0; i < (int)CFDataGetLength((CFDataRef)data); i++) {
            [byteStr appendFormat:@"%02X", ((Byte*)(UInt8 *)CFDataGetBytePtr((CFDataRef)data))[i]];
        }
        
        [FMCDebugTool logType:FMCDebugType_Transport_TCP usingOutput:FMCDebugOutput_DeviceConsole withInfo:[NSString stringWithFormat:@"Read %d bytes: %@", (int)CFDataGetLength((CFDataRef)data), byteStr]];
        
        [transport handleDataReceivedFromTransport:[NSData dataWithBytes:(UInt8 *)CFDataGetBytePtr((CFDataRef)data) length:(int)CFDataGetLength((CFDataRef)data)]];
    } else {
		[FMCDebugTool logInfo:@"unhandled TCPCallback: %d", type];
	}
}

- (bool) connect {
    
    [FMCDebugTool logType:FMCDebugType_Transport_TCP withInfo:@"Init"];

    int sock_fd = call_socket([self.endpointName UTF8String], [self.endpointParam UTF8String]);
	if (sock_fd < 0) {
        
        [FMCDebugTool logType:FMCDebugType_Transport_TCP withInfo:@"Server Not Ready, Connection Failed"];
        
		return NO;
	}
	
	CFSocketContext socketCtxt = {0, self, NULL, NULL, NULL};
	socket = CFSocketCreateWithNative(kCFAllocatorDefault, sock_fd, kCFSocketDataCallBack|kCFSocketConnectCallBack , (CFSocketCallBack) &TCPCallback, &socketCtxt);
	CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, socket, 0);
	CFRunLoopRef loop = CFRunLoopGetCurrent();
	CFRunLoopAddSource(loop, source, kCFRunLoopDefaultMode);
	CFRelease(source);
	
	return sock_fd >= 0;
    return nil;
}

-(NSString*) getHexString:(UInt8*)bytes length:(int) length {
	NSMutableString* ret = [NSMutableString stringWithCapacity:(length * 2)];
	for (int i = 0; i < length; i++) {
		[ret appendFormat:@"%02X", ((Byte*)bytes)[i]];
	}
	return ret;
}

-(NSString*) getHexString:(NSData*) data {
	return [self getHexString:(Byte*)data.bytes length:(int)data.length];
}

- (bool) sendData:(NSData*) msgBytes {
	NSString* byteStr = [self getHexString:msgBytes];
    
    [FMCDebugTool logType:FMCDebugType_Transport_TCP usingOutput:FMCDebugOutput_DeviceConsole withInfo:[NSString stringWithFormat:@"Sent %d bytes: %@", msgBytes.length, byteStr]];
	
	CFSocketError e = CFSocketSendData(socket, NULL, (CFDataRef)msgBytes, 10000);
	return e==0;
}

- (void) dealloc {
	if (socket != nil) {
		CFSocketInvalidate(socket);
		CFRelease(socket);
	}
	
	[super dealloc];
}

@end
