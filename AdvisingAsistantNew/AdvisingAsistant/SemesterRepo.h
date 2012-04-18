//
//  ScheduleRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "Student.h"
#import "Template.h"

@interface SemesterRepo : Repo

+(SemesterRepo*)defaultRepo;

-(NSArray*)semestersForStudent:(Student*)student;
-(NSArray*)semestersForTemplate:(Template*)template;

-(void)saveSemesters:(NSArray *)schedules forStudent:(Student*)student;
-(void)saveSemesters:(NSArray *)schedules forTemplate:(Template*)template;

@end
