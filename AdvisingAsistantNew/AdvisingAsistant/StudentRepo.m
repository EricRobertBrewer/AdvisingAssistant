//
//  StudentRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "StudentRepo.h"

static StudentRepo *instance = nil;

@implementation StudentRepo

+(StudentRepo*)defaultRepo {
	if (instance == nil) {
		instance = [[StudentRepo alloc] init];
	}
	return instance;
}

-(Student*)studentWithId:(int)id {
	return nil;
}

-(void)saveStudent:(Student *)student {
	self.error = @"Could not connect to server";
}

@end
