//  FMCAbstractTransport.m
//  FMCAbstractSyncTransport.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import "FMCAbstractTransport.h"

@implementation FMCAbstractTransport

- (id) initWithEndpoint:(NSString*) endpoint endpointParam:(NSString*) param {
    if (self = [super init]) {
        _endpointName = endpoint;
        _endpointParam = param;
        _debugConsoleGroupName = @"default";
    }
    return self;
}

- (void)notifyTransportConnected {
    [self.delegate onTransportConnected];
}

- (void)notifyTransportDisconnected {
    [self.delegate onTransportDisconnected];
}

- (void)handleDataReceivedFromTransport:(NSData *)receivedData {
    [self.delegate onDataReceived:receivedData];
}


#pragma mark FMCTransport Implementation
- (void)connect {
	[self doesNotRecognizeSelector:_cmd];
}

- (void)disconnect {
	[self doesNotRecognizeSelector:_cmd];
}

- (void)sendData:(NSData *)dataToSend {
	[self doesNotRecognizeSelector:_cmd];
}

@end
