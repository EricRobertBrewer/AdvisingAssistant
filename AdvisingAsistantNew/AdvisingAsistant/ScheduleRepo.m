//
//  ScheduleRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "ScheduleRepo.h"

static ScheduleRepo *instance = nil;

@implementation ScheduleRepo
@synthesize error = _error;

-(void)dealloc {
	self.error = nil;
	[super dealloc];
}

+(ScheduleRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[ScheduleRepo alloc] init];
	}
	return instance;
}

-(NSArray*)schedulesForStudent:(Student*)student {
	self.error = nil;
	return [NSArray array];
}
-(NSArray*)schedulesForTemplate:(Template*)template {
	self.error = nil;
	return [NSArray array];
}

-(void)saveSchedules:(NSArray *)schedules forStudent:(Student*)student {
	self.error = @"Could not connect to server";
}
-(void)saveSchedules:(NSArray *)schedules forTemplate:(Template*)template {
	self.error = @"Could not connect to server";
}

@end
