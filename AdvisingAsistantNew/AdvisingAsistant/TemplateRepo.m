//
//  TemplateRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "TemplateRepo.h"
#import "DepartmentRepo.h"

static TemplateRepo *instance = nil;


@implementation TemplateRepo

-(void)dealloc {
    [_allTemplates release];
    [super dealloc];
}

+(TemplateRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[TemplateRepo alloc] init];
	}
	return instance;
}

-(Template *)templateFromDict:(NSDictionary *)dict {
    Template *template = [[Template alloc] init];
    template.id = [[dict objectForKey:@"TemplateId"] intValue];
    template.name = [dict objectForKey:@"Name"];
    NSString *department = [dict objectForKey:@"DepartmentID"];
    template.department = [[DepartmentRepo defaultRepo] departmentWithCode:department];
    return template;
}

-(NSArray *)allTemplates {
	if (!_allTemplates) {
		ConnectOptions *options = [ConnectOptions optionsWithUrl:@"fullTemplate.php"];
		NSArray *dicts = [self connect:options];
		if (dicts) {
			NSMutableArray *templates = [[NSMutableArray alloc] init];
			for (NSDictionary *dict in dicts) {
				[templates addObject:[self templateFromDict:dict]];
			}
			_allTemplates = templates;
		}
	}
	return _allTemplates;
}

-(NSArray *)templatesForDepartment:(Department *)department {
	NSMutableArray *templates = [[NSMutableArray alloc] init];
	for (Template *t in self.allTemplates) {
		if ([t.department isEqualToDepartment:department]) {
			[templates addObject:t];
		}
	}
	return templates;
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
