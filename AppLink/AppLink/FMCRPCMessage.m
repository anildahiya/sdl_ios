//  FMCRPCMessage.m
//  SyncProxy
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <AppLink/FMCRPCMessage.h>

#import <AppLink/FMCNames.h>
#import <AppLink/FMCDebugTool.h>

@implementation FMCRPCStruct

-(id) initWithDictionary:(NSMutableDictionary*) dict {
	if (self = [super init]) {
		store = [dict retain];
	}
	return self;
}

-(id) init {
	if (self = [super init]) {
		store = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(NSMutableDictionary*) serializeDictionary:(NSDictionary*) dict version:(Byte) version {
	
	NSMutableDictionary* ret = [NSMutableDictionary dictionaryWithCapacity:dict.count];
	for (NSString* key in [dict keyEnumerator]) {
		NSObject* value = [dict objectForKey:key];
		if ([value isKindOfClass:FMCRPCStruct.class]) {
			[ret setObject:[(FMCRPCStruct*)value serializeAsDictionary:version] forKey:key];
		} else if ([value isKindOfClass:NSDictionary.class]) {
			[ret setObject:[self serializeDictionary:(NSDictionary*)value version:version] forKey:key];
		} else if ([value isKindOfClass:NSArray.class]) {
			NSArray* arrayVal = (NSArray*) value;
			
			if (arrayVal.count > 0 
				&& ([[arrayVal objectAtIndex:0] isKindOfClass:FMCRPCStruct.class])) {
				NSMutableArray* serializedList = [NSMutableArray arrayWithCapacity:arrayVal.count];
				for (FMCRPCStruct* serializeable in arrayVal) {
					[serializedList addObject:[serializeable serializeAsDictionary:version]];
				}
				[ret setObject:serializedList forKey:key];
			} else if (arrayVal.count > 0 
					 && ([[arrayVal objectAtIndex:0] isKindOfClass:FMCEnum.class])) {
				NSMutableArray* serializedList = [NSMutableArray arrayWithCapacity:arrayVal.count];
				for (FMCEnum* anEnum in arrayVal) {
					[serializedList addObject:anEnum.value];
				}
				[ret setObject:serializedList forKey:key];
			} else {
				[ret setObject:value forKey:key];
			}
		} else if ([value isKindOfClass:FMCEnum.class]) {
			[ret setObject:((FMCEnum*)value).value forKey:key];
		} else {
			[ret setObject:value forKey:key];
		}
	}
	return ret;
}

-(NSMutableDictionary*) serializeAsDictionary:(Byte) version {
    if (version == 2) {
        NSString* messageType = [[store keyEnumerator] nextObject];
		NSMutableDictionary* function = [[store objectForKey:messageType] retain];
        if ([function isKindOfClass:NSMutableDictionary.class]) {
            NSMutableDictionary* parameters = [[function objectForKey:NAMES_parameters] retain];
            return [self serializeDictionary:parameters version:version];
        } else {
            return [self serializeDictionary:store version:version];
        }
    } else {
        return [self serializeDictionary:store version:version];
    }
}

-(void) dealloc {
    [store release];
    [super dealloc];
}

@end

@implementation FMCRPCMessage

@synthesize messageType;

-(id) initWithName:(NSString*) name {
	if (self = [super init]) {
		function = [[NSMutableDictionary alloc] initWithCapacity:3];
		parameters = [[NSMutableDictionary alloc] init];
		messageType = NAMES_request;
		[store setObject:function forKey:messageType];
		[function setObject:parameters forKey:NAMES_parameters];
		[function setObject:name forKey:NAMES_operation_name];
	}
	return self;
}

-(id) initWithDictionary:(NSMutableDictionary*) dict {
	if (self = [super initWithDictionary:dict]) {

        NSEnumerator *enumerator = [store keyEnumerator];
        while (messageType = [enumerator nextObject]) {
            if ([messageType isEqualToString:@"bulkData"] == FALSE){
                break;
            }
        }
		
		function = [[store objectForKey:messageType] retain];
		parameters = [[function objectForKey:NAMES_parameters] retain];
	}
	return self;
}

-(NSString*) getFunctionName {
	return [function objectForKey:NAMES_operation_name];
}

-(void) setFunctionName:(NSString*) functionName {
    if (functionName != nil) {
        [function setObject:functionName forKey:NAMES_operation_name];
    } else {
        [function removeObjectForKey:NAMES_operation_name];
    }
}

-(NSObject*) getParameters:(NSString*) functionName {
    return [parameters objectForKey:functionName];
}

-(void) setParameters:(NSString*) functionName value:(NSObject*) value {
    if (value != nil) {
        [parameters setObject:value forKey:functionName];
    } else {
        [parameters removeObjectForKey:functionName];
    }
}

-(NSData*) getBulkData {
    return _bulkData;
}

-(void) setBulkData:(NSData*) bulkData
{
    if(bulkData != _bulkData)
        [_bulkData release];

    _bulkData = [NSData dataWithData:bulkData];
}

-(void) dealloc {
	[function release];
	[parameters release];
    [_bulkData release];
	
	[super dealloc];
}

-(NSString*) name {
	return [function objectForKey:NAMES_operation_name];
}

@end
