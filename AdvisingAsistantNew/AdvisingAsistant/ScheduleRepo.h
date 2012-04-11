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

@interface ScheduleRepo : Repo

+(ScheduleRepo*)defaultRepo;

-(NSArray*)schedulesForStudent:(Student*)student;
-(NSArray*)schedulesForTemplate:(Template*)template;

-(void)saveSchedules:(NSArray *)schedules forStudent:(Student*)student;
-(void)saveSchedules:(NSArray *)schedules forTemplate:(Template*)template;

@end
