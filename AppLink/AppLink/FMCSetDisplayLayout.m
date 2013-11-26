//  FMCSetDisplayLayout.m
//  SyncProxy
//  Copyright (c) 2013 Ford Motor Company. All rights reserved.

#import <AppLink/FMCSetDisplayLayout.h>

#import <AppLink/FMCNames.h>

@implementation FMCSetDisplayLayout

-(id) init {
    if (self = [super initWithName:NAMES_SetDisplayLayout]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setDisplayLayout:(NSString *) displayLayout {
    if (displayLayout != nil) {
        [parameters setObject:displayLayout forKey:NAMES_displayLayout];
    } else {
        [parameters removeObjectForKey:NAMES_displayLayout];
    }
}

-(NSString*) displayLayout {
    return [parameters objectForKey:NAMES_displayLayout];
}

@end
