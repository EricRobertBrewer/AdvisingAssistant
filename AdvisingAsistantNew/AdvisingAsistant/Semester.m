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

-(NSString *)getDateAsString {
    NSString *dateAsString = [[NSString alloc] init];
    
    if (self.date.season == SeasonFall) {
        dateAsString = [[[NSString alloc] initWithFormat:@"Fall %d",self.date.year] autorelease];
    }
    else if (self.date.season == SeasonSpring) {
        dateAsString = [[[NSString alloc] initWithFormat:@"Spring %d",self.date.year] autorelease];
    }
        
    return dateAsString;
}

-(void)dealloc {
	self.courses = nil;
	[super dealloc];
}

@end
