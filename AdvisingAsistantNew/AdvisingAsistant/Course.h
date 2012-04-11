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
} Availabile;

@interface Course : NSObject

@property (nonatomic, retain) Department *department; // ie ES
@property (nonatomic, assign) Availabile available;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, assign) int units;
@property (nonatomic, retain) NSString *name; // ie ES 101A

@end
