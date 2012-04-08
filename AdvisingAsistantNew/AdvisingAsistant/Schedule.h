//
//  Schedule.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Semester.h"

@interface Schedule : NSObject

@property (nonatomic, assign) Semester semester;
@property (nonatomic, retain) NSArray *courses;

@end
