//
//  DepartmentRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "Department.h"

@interface DepartmentRepo : Repo {
	NSArray *_allDepartments;
}

+(DepartmentRepo *)defaultRepo;

-(NSArray *)allDepartments;

// returns nil if no department found
-(Department *)departmentWithCode:(NSString *)code;

@end
