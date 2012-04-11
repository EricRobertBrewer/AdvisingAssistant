//
//  Template.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Template.h"

@implementation Template

@synthesize id;
@synthesize department;
@synthesize name;

-(void)dealloc {
	self.department = nil;
	self.name = nil;
	[super dealloc];
}

@end
