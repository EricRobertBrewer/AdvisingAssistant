//
//  CourseRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
#import "Repo.h"

@interface CourseRepo : Repo {
	NSArray *_allCourses;
}

+(CourseRepo *)defaultRepo;

-(Course *)courseWithDepartment:(Department *)department andNumber:(NSString *)number;

@end
