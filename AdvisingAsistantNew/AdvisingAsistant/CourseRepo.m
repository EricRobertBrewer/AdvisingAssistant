//
//  CourseRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "CourseRepo.h"
#import "DepartmentRepo.h"

static CourseRepo *instance = nil;

@implementation CourseRepo

-(void)dealloc {
	[_allCourses release];
	[super dealloc];
}

/*
	DICTIONARY SERIALIZING
*/

-(Course *)courseFromDict:(NSDictionary *)dict {
	Course *course = [[Course alloc] init];
	
	NSString *department = [dict objectForKey:@"DepartmentID"];
	course.department = [[DepartmentRepo defaultRepo] departmentWithCode:department];

	NSString *available = [dict objectForKey:@"Semester"];
	if ([available isEqualToString:@"F"]) course.available = AvailabileFall;
	else if ([available isEqualToString:@"S"]) course.available = AvailabileSpring;
	else course.available = AvailabileAll;
	
	course.number = [dict objectForKey:@"CourseID"];
	course.title = [dict objectForKey:@"Name"];
	course.description = [dict objectForKey:@"Description"];
	course.units = [[dict objectForKey:@"Units"] intValue];
	
	return [course autorelease];
}

/*
	GETTING COURSES
*/

-(NSArray *)allCourses {
	if (!_allCourses) {
		ConnectOptions *options = [ConnectOptions optionsWithUrl:@"fullCourse.php"];
		NSArray *dicts = [self connect:options];
		if (dicts) {
			NSMutableArray *courses = [[NSMutableArray alloc] init];
			for (NSDictionary *dict in dicts) {
				[courses addObject:[self courseFromDict:dict]];
			}
			_allCourses = courses;
		}
	}
	return _allCourses;
}

-(Course *)courseWithDepartment:(Department *)department andNumber:(NSString *)number {
	for (Course *course in self.allCourses) {
		if ([course.department isEqualToDepartment:department]
			&& [course.number isEqualToString:number]) {
			return course;
		}
	}
	return nil;
}

/*
	SINGLETON STUFF
*/

+(CourseRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[CourseRepo alloc] init];
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
