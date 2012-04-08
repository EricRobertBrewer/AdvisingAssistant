//
//  Student.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Student.h"

@implementation Student

@synthesize id;
@synthesize name;
@synthesize started;

-(void)dealloc {
	self.name = nil;
	[super dealloc];
}

@end
