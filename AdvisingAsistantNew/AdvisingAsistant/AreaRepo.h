//
//  AreaRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/23/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "GEPattern.h"
#import "Department.h"
#import "SemesterDate.h"
#import "Area.h"

@interface AreaRepo : Repo

+(AreaRepo *)defaultRepo;

-(NSArray *)areasForGEPattern:(GEPattern)pattern date:(SemesterDate)date;
-(NSArray *)areasForDepartment:(Department *)department date:(SemesterDate)date;

-(NSArray *)areasForArea:(Area *)area;

@end
