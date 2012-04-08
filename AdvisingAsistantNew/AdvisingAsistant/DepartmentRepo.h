//
//  DepartmentRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartmentRepo : NSObject

+(DepartmentRepo *)defaultRepo;

-(NSArray *)allDepartments;

@property (nonatomic, retain) NSString *error;

@end
