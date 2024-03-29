//
//  Schedule.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Semester.h"

@implementation Semester
@synthesize date = _date;
@synthesize courses = _courses;

-(void)dealloc {
	self.courses = nil;
	[super dealloc];
}

-(id)init {
    if ((self = [super init])) {
        self.courses = [NSMutableArray array];
    }
    return self;
}

-(NSString *)getDateAsString {
	return FormatSemesterDate(self.date);
}

@end
