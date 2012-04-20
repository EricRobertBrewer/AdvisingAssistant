//
//  Schedule.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemesterDate.h"

@interface Semester : NSObject

@property (nonatomic, assign) SemesterDate date;
@property (nonatomic, retain) NSMutableArray *courses;

@end
