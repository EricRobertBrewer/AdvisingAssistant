//
//  AreaRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/23/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "AreaRepo.h"

static AreaRepo *instance = nil;

@implementation AreaRepo

-(NSArray *)areasForArea:(Area *)area {
	self.error = @"Not yet implemented";
	return [NSArray array];
}

-(NSArray *)areasForDepartment:(Department *)department date:(SemesterDate)date {
	self.error = @"Not yet implemented";
	return [NSArray array];	
}

-(NSArray *)areasForGEPattern:(GEPattern)pattern date:(SemesterDate)date {
	self.error = @"Not yet implemented";
	return [NSArray array];
}


/*
 SINGLETON STUFF
 */

+(AreaRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[AreaRepo alloc] init];
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
