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

/*
	SERIALIZING TO/FROM DICTIONARIES
*/

-(Template *)templateFromDict:(NSDictionary *)dict {
    Template *template = [[Template alloc] init];
    template.id = [[dict objectForKey:@"TemplateId"] intValue];
    template.name = [dict objectForKey:@"Name"];
    NSString *department = [dict objectForKey:@"DepartmentID"];
    template.department = [[DepartmentRepo defaultRepo] departmentWithCode:department];
    return template;
}

-(NSMutableDictionary *)dictFromTemplate:(Template *)template {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	if (template.id > 0) {
		[dict setInt:template.id forKey:@"TemplateId"];
	}
	[dict setValue:template.name forKey:@"Name"];
	[dict setValue:template.department.code forKey:@"DepartmentID"];
	return dict;
}

/*
	GETTING TEMPLATES
*/

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

/*
	SAVING TEMPLATES
*/

-(void)saveTemplate:(Template *)template {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"insertTemplate.php"];
	options.postData = [self dictFromTemplate:template];
	[self connect:options];
}

/*
	SINGLETON STUFF
*/

+(TemplateRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[TemplateRepo alloc] init];
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
