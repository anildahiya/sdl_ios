//  SDLSmartDeviceLinkProtocol.h
//

#import "SDLAbstractProtocol.h"
@class SDLProtocolHeader;
@class SDLProtocolRecievedMessageRouter;


@interface SDLProtocol : SDLAbstractProtocol <SDLProtocolListener>

// Sending
- (void)sendStartSessionWithType:(SDLServiceType)serviceType;
- (void)sendEndSessionWithType:(SDLServiceType)serviceType sessionID:(Byte)sessionID;
- (void)sendRPC:(SDLRPCMessage *)message;
- (void)sendRPCRequest:(SDLRPCRequest *)rpcRequest __deprecated_msg(("Use sendRPC: instead"));
- (void)sendHeartbeat;
- (void)sendRawData:(NSData *)data withServiceType:(SDLServiceType)serviceType;

// Recieving
- (void)handleBytesFromTransport:(NSData *)receivedData;

@end
