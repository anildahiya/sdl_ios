//  FMCEnum.m
//  SyncProxy
//  Copyright (c) 2013 Ford Motor Company. All rights reserved.

#import <AppLink/FMCEnum.h>

@implementation FMCEnum

@synthesize value;

-(id) initWithValue:(NSString*) aValue {
	if (self = [super init]) {
		value = aValue;
	}
	return self;
}

-(NSString*) description {
	return value;
}

@end
