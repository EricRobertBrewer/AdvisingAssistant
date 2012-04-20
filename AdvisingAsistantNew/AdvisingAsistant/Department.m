//
//  Department.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Department.h"

@implementation Department

@synthesize code;
@synthesize name;

-(void)dealloc {
	self.code = nil;
	self.name = nil;
	[super dealloc];
}

-(BOOL)isEqualToDepartment:(Department *)department {
	return self.code == department.code;
}

@end
