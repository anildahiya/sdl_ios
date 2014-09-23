//  FMCOnHashChange.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCOnHashChange.h>

#import <AppLink/FMCNames.h>

@implementation FMCOnHashChange

-(id) init {
    if (self = [super initWithName:NAMES_OnHashChange]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setHashID:(NSString*) hashID {
    if (hashID != nil) {
        [parameters setObject:hashID forKey:NAMES_hashID];
    } else {
        [parameters removeObjectForKey:NAMES_hashID];
    }
}

-(NSString*) hashID {
    return [parameters objectForKey:NAMES_hashID];
}

@end