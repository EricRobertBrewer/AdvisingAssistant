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
	AvailabileAll,
	AvailabileFall,
	AvailabileSpring
} Available;

@interface Course : NSObject

@property (nonatomic, retain) Department *department; // ie ES
@property (nonatomic, retain) NSString *number; // ie 101A
@property (nonatomic, readonly) NSString *name; // ie ES 101A
@property (nonatomic, retain) NSString *title; // ie Theory of Computation
@property (nonatomic, retain) NSString *description; // ie Lecture 4 hourse. Mathematical study of...
@property (nonatomic, assign) Available available;
@property (nonatomic, assign) int units;

@property (nonatomic, retain) NSString *customName;

-(id)init;
-(id)initWithCourse:(Course *)course;
+(Course *)courseWithCourse:(Course *)course; // Make a copy

-(BOOL)isEqualToCourse:(Course *)course;

-(BOOL)meetsPrereqs:(NSArray *)semesters;
-(BOOL)meetsCoreqs:(NSArray *)semesters;

@end
