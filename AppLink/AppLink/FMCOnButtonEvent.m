//  FMCOnButtonEvent.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCOnButtonEvent.h>

#import <AppLink/FMCNames.h>

@implementation FMCOnButtonEvent

-(id) init {
    if (self = [super initWithName:NAMES_OnButtonEvent]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setButtonName:(FMCButtonName*) buttonName {
    if (buttonName != nil) {
        [parameters setObject:buttonName forKey:NAMES_buttonName];
    } else {
        [parameters removeObjectForKey:NAMES_buttonName];
    }
}

-(FMCButtonName*) buttonName {
    NSObject* obj = [parameters objectForKey:NAMES_buttonName];
    if ([obj isKindOfClass:FMCButtonName.class]) {
        return (FMCButtonName*)obj;
    } else {
        return [FMCButtonName valueOf:(NSString*)obj];
    }
}

-(void) setButtonEventMode:(FMCButtonEventMode*) buttonEventMode {
    if (buttonEventMode != nil) {
        [parameters setObject:buttonEventMode forKey:NAMES_buttonEventMode];
    } else {
        [parameters removeObjectForKey:NAMES_buttonEventMode];
    }
}

-(FMCButtonEventMode*) buttonEventMode {
    NSObject* obj = [parameters objectForKey:NAMES_buttonEventMode];
    if ([obj isKindOfClass:FMCButtonEventMode.class]) {
        return (FMCButtonEventMode*)obj;
    } else {
        return [FMCButtonEventMode valueOf:(NSString*)obj];
    }
}

-(void) setCustomButtonID:(NSNumber*) customButtonID {
    if (customButtonID != nil) {
        [parameters setObject:customButtonID forKey:NAMES_customButtonID];
    } else {
        [parameters removeObjectForKey:NAMES_customButtonID];
    }
}

-(NSNumber*) customButtonID {
    return [parameters objectForKey:NAMES_customButtonID];
}

@end
