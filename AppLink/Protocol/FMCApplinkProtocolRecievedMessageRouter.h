//
//  FMCApplinkProtocolRecievedMessageRouter.h
//  ProtocolReWrite
//

#import <Foundation/Foundation.h>
#import "FMCProtocolListener.h"
@class FMCAppLinkProtocolMessage;


@interface FMCApplinkProtocolRecievedMessageRouter : NSObject

@property (weak) id<FMCProtocolListener> delegate;

- (void)handleRecievedMessage:(FMCAppLinkProtocolMessage *)message;

@end
