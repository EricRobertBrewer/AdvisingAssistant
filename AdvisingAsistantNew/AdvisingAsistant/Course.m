//
//  Class.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Course.h"

@implementation Course

@synthesize department;
@synthesize number;
@synthesize available;
@synthesize description;

-(void)dealloc {
	self.department = nil;
	self.description = nil;
	[super dealloc];
}

@end
