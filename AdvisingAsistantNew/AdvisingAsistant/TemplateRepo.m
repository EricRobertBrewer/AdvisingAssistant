//
//  TemplateRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "TemplateRepo.h"

static TemplateRepo *instance = nil;

@implementation TemplateRepo

+(TemplateRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[TemplateRepo alloc] init];
	}
	return instance;
}

-(NSArray *)templatesForDepartment:(Department *)department {
	self.error = nil;
	return [NSArray array];
}

-(void)saveTemplate:(Template *)template {
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
