//  FMCReadDIDResponse.m
//  SyncProxy
//  Copyright (c) 2013 Ford Motor Company. All rights reserved.

#import <AppLink/FMCReadDIDResponse.h>

#import <AppLink/FMCNames.h>

@implementation FMCReadDIDResponse

-(id) init {
    if (self = [super initWithName:NAMES_ReadDID]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setDidResult:(NSMutableArray*) didResult {
    if (didResult != nil) {
        [parameters setObject:didResult forKey:NAMES_didResult];
    } else {
        [parameters removeObjectForKey:NAMES_didResult];
    }
}

-(NSMutableArray*) didResult {
    NSMutableArray* array = [parameters objectForKey:NAMES_didResult];
    if ([array count] < 1 || [[array objectAtIndex:0] isKindOfClass:FMCDIDResult.class]) {
        return array;
    } else { 
        NSMutableArray* newList = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSString* enumString in array) {
            //TODO: Cleanup
            //[newList addObject:[FMDIDResult valueOf:enumString]];
            [newList addObject:enumString];
        }
        return newList;
    }
}


@end
