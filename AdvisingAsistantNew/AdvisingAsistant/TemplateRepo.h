//
//  TemplateRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "Department.h"
#import "Template.h"

@interface TemplateRepo : Repo

+(TemplateRepo *)defaultRepo;

-(NSArray *)templatesForDepartment:(Department *)department;
-(void)saveTemplate:(Template *)template;

@end