//
//  StudentRepo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface StudentRepo : NSObject

+(StudentRepo*)defaultRepo;

// Retuns nil if no student found
-(Student*)studentWithId:(int)id;

-(void)saveStudent:(Student*)student;

@property (nonatomic, retain) NSString *error;

@end
