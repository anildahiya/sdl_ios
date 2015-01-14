//
//  FMCIAPSession.h
//  AppLink
//
//  Copyright (c) 2014 FMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "FMCIAPSessionDelegate.h"
#import "FMCStreamDelegate.h"

typedef void(^SessionCompletionHandler)(BOOL success);

@interface FMCIAPSession : NSObject

@property (strong, atomic) EAAccessory *accessory;
@property (strong, atomic) NSString *protocol;
@property (strong, atomic) EASession *easession;
@property (weak) id<FMCIAPSessionDelegate> delegate;
@property (strong, atomic) FMCStreamDelegate *streamDelegate;

- (instancetype)initWithAccessory:(EAAccessory *)accessory
                      forProtocol:(NSString *)protocol;

- (BOOL)start;
- (void)stop;

@end
