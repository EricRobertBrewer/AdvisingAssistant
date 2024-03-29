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

-(NSArray *)coursesFromDicts:(NSArray *)dicts {
    NSMutableArray *courses = [NSMutableArray array];
    for (NSDictionary *dict in dicts) {
        [courses addObject:[self courseFromDict:dict]];
    }
    return courses;
}

/*
	GETTING COURSES
*/

-(NSArray *)prereqsForCourse:(Course *)course {
    ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getPrereqsForCourse.php"];
    [options.postData setValue:course.department.code forKey:@"DepartmentID"];
    [options.postData setValue:course.number forKey:@"CourseID"];
    return [self coursesFromDicts:[self connect:options]];
}
-(NSArray *)coreqsForCourse:(Course *)course {
    ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getCoreqsForCourse.php"];
    [options.postData setValue:course.department.code forKey:@"DepartmentID"];
    [options.postData setValue:course.number forKey:@"CourseID"];
    return [self coursesFromDicts:[self connect:options]];
}

-(NSArray *)coursesForArea:(Area *)area {
    ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getCoursesForArea.php"];
    [options.postData setValue:area.name forKey:@"Area"];
	return [self coursesFromDicts:[self connect:options]];
}

-(NSArray *)allCourses {
	if (!_allCourses) {
		ConnectOptions *options = [ConnectOptions optionsWithUrl:@"fullCourse.php"];
        _allCourses = [[self coursesFromDicts:[self connect:options]] retain];
	}
	return _allCourses;
}

-(Course *)courseWithDepartment:(Department *)department andNumber:(NSString *)number {
	for (Course *course in self.allCourses) {
		if ([course.department isEqualToDepartment:department]
			&& [course.number isEqualToString:number]) {
			return [Course courseWithCourse:course]; // Make a copy
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
