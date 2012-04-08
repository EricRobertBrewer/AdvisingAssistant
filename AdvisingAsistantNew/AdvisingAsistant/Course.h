//
//  Class.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"

typedef enum {
	CourseAvailabileAll,
	CourseAvailabileFall,
	CourseAvailabileSpring
} CourseAvailabile;

@interface Course : NSObject

@property (nonatomic, retain) Department *department;
@property (nonatomic, assign) int number; // ie 315
@property (nonatomic, assign) CourseAvailabile available;
@property (nonatomic, retain) NSString *description;

@end
