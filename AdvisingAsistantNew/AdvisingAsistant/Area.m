//
//  Area.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/23/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "Area.h"

@implementation Area
@synthesize name = _name;
@synthesize title = _title;

-(void)dealloc {
	self.name = nil;
	self.title = nil;
	[super dealloc];
}

@end
