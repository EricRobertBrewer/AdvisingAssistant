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

+(id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (instance == nil) {
			instance = [super allocWithZone:zone];
			return instance; // assignment and return on first allocation
		}
	}
	return nil; // on subsequent allocation attempts return nil
}
@end
