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

-(BOOL)meets:(NSArray *)criteria withSemesters:(NSArray *)semesters {
    for (Course *course in criteria) {
        BOOL found = false;
        for (Semester *semester in semesters) {
            for (Course *c in semester.courses) {
                if ([course isEqualToCourse:c]) {
                    found = YES;
                    break;
                }
            }
        }
        if (!found) return NO;
    }
    return YES;
}

-(BOOL)meetsPrereqs:(NSArray *)semesters {
    NSArray *prereqs = [[CourseRepo defaultRepo] prereqsForCourse:self];
    return [self meets:prereqs withSemesters:semesters];
}

-(BOOL)meetsCoreqs:(NSArray *)semesters {
    NSArray *coreqs = [[CourseRepo defaultRepo] coreqsForCourse:self];
    return [self meets:coreqs withSemesters:semesters];
}

@end
