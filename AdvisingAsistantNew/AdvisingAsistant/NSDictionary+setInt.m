//
//  NSDictionary+setInt.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "NSDictionary+setInt.h"

@implementation NSDictionary (setInt)

-(void)setInt:(int)value forKey:(NSString *)key {
	NSString *s = [NSString stringWithFormat:@"%i", value];
	[self setValue:s forKey:key];
}

@end
