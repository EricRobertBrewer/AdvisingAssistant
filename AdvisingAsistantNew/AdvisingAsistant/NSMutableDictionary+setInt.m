//
//  NSDictionary+setInt.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "NSMutableDictionary+setInt.h"

@implementation NSMutableDictionary (setInt)

-(void)setInt:(int)value forKey:(NSString *)key {
	NSString *s = [NSString stringWithFormat:@"%i", value];
	[self setValue:s forKey:key];
}

-(void)setValues:(NSDictionary *)other {
	for (NSString *key in other.allKeys) {
		id value = [other objectForKey:value];
		[self setValue:value forKey:key];
	}
}

@end
