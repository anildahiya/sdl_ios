//  SDLUpdateTurnList.m
//  SmartDeviceLink
//  Copyright (c) 2013 Ford Motor Company

#import <SmartDeviceLink/SDLUpdateTurnList.h>

#import <SmartDeviceLink/SDLNames.h>
#import <SmartDeviceLink/SDLSoftButton.h>
#import <SmartDeviceLink/SDLTurn.h>

@implementation SDLUpdateTurnList

-(id) init {
    if (self = [super initWithName:NAMES_UpdateTurnList]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setTurnList:(NSMutableArray *) turnList {
    if (turnList != nil) {
        [parameters setObject:turnList forKey:NAMES_turnList];
    } else {
        [parameters removeObjectForKey:NAMES_turnList];
    }
}

-(NSMutableArray*) turnList {
    NSMutableArray* array = [parameters objectForKey:NAMES_turnList];
    if ([array count] < 1 || [[array objectAtIndex:0] isKindOfClass:SDLTurn.class]) {
        return array;
    } else {
        NSMutableArray* newList = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSDictionary* dict in array) {
            [newList addObject:[[[SDLTurn alloc] initWithDictionary:(NSMutableDictionary*)dict] autorelease]];
        }
        return newList;
    }
}

-(void) setSoftButtons:(NSMutableArray *) softButtons {
    if (softButtons != nil) {
        [parameters setObject:softButtons forKey:NAMES_softButtons];
    } else {
        [parameters removeObjectForKey:NAMES_softButtons];
    }
}

-(NSMutableArray*) softButtons {
    NSMutableArray* array = [parameters objectForKey:NAMES_softButtons];
    if ([array count] < 1 || [[array objectAtIndex:0] isKindOfClass:SDLSoftButton.class]) {
        return array;
    } else {
        NSMutableArray* newList = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSDictionary* dict in array) {
            [newList addObject:[[[SDLSoftButton alloc] initWithDictionary:(NSMutableDictionary*)dict] autorelease]];
        }
        return newList;
    }
}

@end
