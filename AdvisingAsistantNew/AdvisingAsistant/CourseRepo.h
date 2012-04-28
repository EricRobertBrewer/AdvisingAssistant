//
//  CourseRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "Area.h"
#import "Course.h"

@interface CourseRepo : Repo {
	NSArray *_allCourses;
}

+(CourseRepo *)defaultRepo;

// Returns array of courses
-(NSArray *)prereqsForCourse:(Course *)course;
-(NSArray *)coreqsForCourse:(Course *)course;

-(NSArray *)coursesForArea:(Area *)area;
-(Course *)courseWithDepartment:(Department *)department andNumber:(NSString *)number;

@end
