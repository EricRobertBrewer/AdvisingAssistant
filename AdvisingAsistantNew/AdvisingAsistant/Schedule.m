//
//  Schedule.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize semester;
@synthesize courses;

-(void)dealloc {
	self.courses = nil;
	[super dealloc];
}

@end