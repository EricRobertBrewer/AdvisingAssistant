//
//  ScheduleRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "SemesterRepo.h"

static SemesterRepo *instance = nil;

@implementation SemesterRepo

+(SemesterRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[SemesterRepo alloc] init];
	}
	return instance;
}

-(NSArray*)semestersForStudent:(Student*)student {
	self.error = nil;
	return [NSArray array];
}
-(NSArray*)semestersForTemplate:(Template*)template {
	self.error = nil;
	return [NSArray array];
}

-(void)saveSemesters:(NSArray *)schedules forStudent:(Student*)student {
	self.error = @"Could not connect to server";
}
-(void)saveSemesters:(NSArray *)schedules forTemplate:(Template*)template {
	self.error = @"Could not connect to server";
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
