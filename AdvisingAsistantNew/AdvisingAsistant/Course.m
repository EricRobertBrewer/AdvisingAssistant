//
//  Class.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Course.h"
#import "CourseRepo.h"
#import "Semester.h"

@implementation Course

@synthesize department = _department;
@synthesize available = _available;
@synthesize title = _title;
@synthesize description = _description;
@synthesize units = _units;
@synthesize number = _number;
@synthesize customName = _customName;

-(void)dealloc {
	self.department = nil;
	self.title = nil;
	self.description = nil;
	self.number = nil;
	self.customName = nil;
	[super dealloc];
}

-(NSString *)name {
	return [NSString stringWithFormat:@"%@ %@", self.department.code, self.number];
}

-(id)init {
	return [super init];
}
-(id)initWithCourse:(Course *)course {
	if ((self = [super init])) {
		self.department = course.department;
		self.available = course.available;
		self.title = course.title;
		self.description = course.description;
		self.units = course.units;
		self.number = course.number;
		self.customName = course.customName;
	}
	return self;
}

+(Course *)courseWithCourse:(Course *)course {
	return [[[Course alloc] initWithCourse:course] autorelease];
}

-(BOOL)isEqualToCourse:(Course *)course {
    return [self.department isEqualToDepartment:course.department]
        && [self.number isEqualToString:course.number];
}

-(NSArray *)missing:(NSArray *)criteria withSemesters:(NSArray *)semesters by:(SemesterDate)date {
    NSMutableArray *missing = [NSMutableArray array];
    for (Course *course in criteria) {
        BOOL found = false;
        for (Semester *semester in semesters) {
            if (SemesterDateGreaterThan(semester.date, date)) break;
            for (Course *c in semester.courses) {
                if ([course isEqualToCourse:c]) {
                    found = YES;
                    break;
                }
            }
        }
        if (!found) {
            [missing addObject:course];
        }
    }
    return missing;
}

-(NSArray *)missingPrereqs:(NSArray *)semesters by:(SemesterDate)date {
    NSArray *prereqs = [[CourseRepo defaultRepo] prereqsForCourse:self];
    return [self missing:prereqs withSemesters:semesters by:SemesterDatePrevious(date)];
}

-(NSArray *)missingCoreqs:(NSArray *)semesters by:(SemesterDate)date {
    NSArray *coreqs = [[CourseRepo defaultRepo] coreqsForCourse:self];
    return [self missing:coreqs withSemesters:semesters by:date];
}

@end
