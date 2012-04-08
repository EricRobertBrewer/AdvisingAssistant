//
//  DepartmentRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "DepartmentRepo.h"

static DepartmentRepo *instance = nil;

@implementation DepartmentRepo
@synthesize error = _error;

+(DepartmentRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[DepartmentRepo alloc] init];
	}
	return instance;
}

-(NSArray *)allDepartments {
	self.error = nil;
	return [NSArray array];
}

@end
