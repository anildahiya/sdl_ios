//  FMCVehicleType.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCVehicleType.h>

#import <AppLink/FMCNames.h>

@implementation FMCVehicleType

-(id) init {
    if (self = [super init]) {}
    return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
    if (self = [super initWithDictionary:dict]) {}
    return self;
}

-(void) setMake:(NSString*) make {
    if (make != nil) {
        [store setObject:make forKey:NAMES_make];
    } else {
        [store removeObjectForKey:NAMES_make];
    }
}

-(NSString*) make {
    return [store objectForKey:NAMES_make];
}

-(void) setModel:(NSString*) model {
    if (model != nil) {
        [store setObject:model forKey:NAMES_model];
    } else {
        [store removeObjectForKey:NAMES_model];
    }
}

-(NSString*) model {
    return [store objectForKey:NAMES_model];
}

-(void) setModelYear:(NSString*) modelYear {
    if (modelYear != nil) {
        [store setObject:modelYear forKey:NAMES_modelYear];
    } else {
        [store removeObjectForKey:NAMES_modelYear];
    }
}

-(NSString*) modelYear {
    return [store objectForKey:NAMES_modelYear];
}

-(void) setTrim:(NSString*) trim {
    if (trim != nil) {
        [store setObject:trim forKey:NAMES_trim];
    } else {
        [store removeObjectForKey:NAMES_trim];
    }
}

-(NSString*) trim {
    return [store objectForKey:NAMES_trim];
}

@end
