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

@interface TemplateRepo ()
@property (nonatomic, retain) NSArray *allTemplates;
@end

@implementation TemplateRepo
@synthesize allTemplates = _allTemplates;

-(void)dealloc {
    self.allTemplates = nil;
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
    template.department = [[DepartmentRepo defaultRepo] departmentFromCode:department];
    return template;
}

-(NSArray *)getAllTemplates {
    NSMutableArray *templates = [[NSMutableArray alloc] init];
    ConnectOptions *options = [ConnectOptions optionsWithUrl:@"fullTemplate.php"];
    NSArray *dicts = [self connect:options];
    for (NSDictionary *dict in dicts) {
        [templates addObject:[self templateFromDict:dict]];
    }
    return templates;
}

-(NSArray *)templatesForDepartment:(Department *)department {
	if (!self.allTemplates) self.allTemplates = [self getAllTemplates];
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
