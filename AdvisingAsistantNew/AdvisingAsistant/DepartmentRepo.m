//
//  DepartmentRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "DepartmentRepo.h"

static DepartmentRepo *instance = nil;

@interface DepartmentRepo ()
@property (nonatomic, retain) NSArray *allCache;
@end

@implementation DepartmentRepo
@synthesize allCache = _allCache;

-(void)dealloc {
    self.allCache = nil;
    [super dealloc];
}

+(DepartmentRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[DepartmentRepo alloc] init];
	}
	return instance;
}

-(Department*)departmentFromDict:(NSDictionary *)dict {
	Department *d = [[Department alloc] init];
	d.code = [dict objectForKey:@"DepartmentID"];
	d.name = [dict objectForKey:@"Name"];
	return d;
}

-(NSArray *)getAllDepartments {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getDepartment.php"];
	NSArray *dicts = [self connect:options];
	NSMutableArray *departments = [[NSMutableArray alloc] init];
	for (NSDictionary *dict in dicts) {
		[departments addObject:[self departmentFromDict:dict]];
	}
	return departments;
}

-(NSArray *)allDepartments {
    if (!self.allCache) self.allCache = [self getAllDepartments];
    return self.allCache;
}

-(Department *)departmentFromCode:(NSString *)code {
    for (Department *department in self.allCache) {
        if (department.code == code) return department;
    }
    return nil;
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
