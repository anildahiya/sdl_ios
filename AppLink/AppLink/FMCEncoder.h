//  FMCEncoder.h
//  SyncProxy
//  Copyright (c) 2013 Ford Motor Company. All rights reserved.

#import <Foundation/Foundation.h>

@protocol FMCEncoder

-(NSData*) encodeDictionary:(NSDictionary*) dict;

@end
