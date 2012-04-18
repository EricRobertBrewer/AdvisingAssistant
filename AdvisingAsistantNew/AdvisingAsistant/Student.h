//
//  Student.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Semester.h"

@interface Student : NSObject

@property (nonatomic, assign) int id; // SSU Student ID#
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) SemesterDate started;

@end
