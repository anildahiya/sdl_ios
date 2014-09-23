//  FMCRequestType.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCRequestType.h>

FMCRequestType* FMCRequestType_HTTP = nil;
FMCRequestType* FMCRequestType_FILE_RESUME = nil;
FMCRequestType* FMCRequestType_AUTH_REQUEST = nil;
FMCRequestType* FMCRequestType_AUTH_CHALLENGE = nil;
FMCRequestType* FMCRequestType_AUTH_ACK = nil;
FMCRequestType* FMCRequestType_PROPRIETARY = nil;

NSMutableArray* FMCRequestType_values = nil;

@implementation FMCRequestType

+(FMCRequestType*) valueOf:(NSString*) value {
    for (FMCRequestType* item in FMCRequestType.values) {
        if ([item.value isEqualToString:value]) {
            return item;
        }
    }
    return nil;
}

+(NSMutableArray*) values {
    if (FMCRequestType_values == nil) {
        FMCRequestType_values = [[NSMutableArray alloc] initWithObjects:
                FMCRequestType.HTTP,
                FMCRequestType.FILE_RESUME,
                FMCRequestType.AUTH_REQUEST,
                FMCRequestType.AUTH_CHALLENGE,
                FMCRequestType.AUTH_ACK,
                FMCRequestType.PROPRIETARY,
                nil];
    }
    return FMCRequestType_values;
}

+(FMCRequestType*) HTTP {
    if (FMCRequestType_HTTP == nil) {
        FMCRequestType_HTTP = [[FMCRequestType alloc] initWithValue:@"HTTP"];
    }
    return FMCRequestType_HTTP;
}

+(FMCRequestType*) FILE_RESUME {
    if (FMCRequestType_FILE_RESUME == nil) {
        FMCRequestType_FILE_RESUME = [[FMCRequestType alloc] initWithValue:@"FILE_RESUME"];
    }
    return FMCRequestType_FILE_RESUME;
}

+(FMCRequestType*) AUTH_REQUEST {
    if (FMCRequestType_AUTH_REQUEST == nil) {
        FMCRequestType_AUTH_REQUEST = [[FMCRequestType alloc] initWithValue:@"AUTH_REQUEST"];
    }
    return FMCRequestType_AUTH_REQUEST;
}

+(FMCRequestType*) AUTH_CHALLENGE {
    if (FMCRequestType_AUTH_CHALLENGE == nil) {
        FMCRequestType_AUTH_CHALLENGE = [[FMCRequestType alloc] initWithValue:@"AUTH_CHALLENGE"];
    }
    return FMCRequestType_AUTH_CHALLENGE;
}

+(FMCRequestType*) AUTH_ACK {
    if (FMCRequestType_AUTH_ACK == nil) {
        FMCRequestType_AUTH_ACK = [[FMCRequestType alloc] initWithValue:@"AUTH_ACK"];
    }
    return FMCRequestType_AUTH_ACK;
}

+(FMCRequestType*) PROPRIETARY {
    if (FMCRequestType_PROPRIETARY == nil) {
        FMCRequestType_PROPRIETARY = [[FMCRequestType alloc] initWithValue:@"PROPRIETARY"];
    }
    return FMCRequestType_PROPRIETARY;
}

@end