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

-(void)dealloc {
    [_allDepartments release];
    [super dealloc];
}

/*
	DICTIONARY SERIALIZING
*/

-(Department*)departmentFromDict:(NSDictionary *)dict {
	Department *d = [[Department alloc] init];
	d.code = [dict objectForKey:@"DepartmentID"];
	d.name = [dict objectForKey:@"Name"];
	return [d autorelease];
}

/*
	GETTING DEPARTMENTS
*/

-(NSArray *)allDepartments {
	if (!_allDepartments) {
		ConnectOptions *options = [ConnectOptions optionsWithUrl:@"fullDepartment.php"];
		NSArray *dicts = [self connect:options];
		if (dicts) {
			NSMutableArray *departments = [[NSMutableArray alloc] init];
			for (NSDictionary *dict in dicts) {
				[departments addObject:[self departmentFromDict:dict]];
			}
			_allDepartments = departments;
		}
	}
    return _allDepartments;
}

-(Department *)departmentWithCode:(NSString *)code {
    for (Department *department in self.allDepartments) {
        if ([department.code isEqualToString:code]) return department;
    }
    return nil;
}

/*
	SINGLETON STUFF
*/

+(DepartmentRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[DepartmentRepo alloc] init];
	}
	return instance;
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
