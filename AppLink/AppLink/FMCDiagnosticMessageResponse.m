//  FMCDiagnosticMessageResponse.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCDiagnosticMessageResponse.h>

#import <AppLink/FMCNames.h>

@implementation FMCDiagnosticMessageResponse

-(id) init {
    if (self = [super initWithName:NAMES_DiagnosticMessage]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setMessageDataResult:(NSMutableArray*) messageDataResult {
    if (messageDataResult != nil) {
        [parameters setObject:messageDataResult forKey:NAMES_messageDataResult];
    } else {
        [parameters removeObjectForKey:NAMES_messageDataResult];
    }
}

-(NSMutableArray*) messageDataResult {
    return [parameters objectForKey:NAMES_messageDataResult];
}

@end
