//
//  Template.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"

@interface Template : NSObject

@property (nonatomic, retain) Department *department;
@property (nonatomic, retain) NSString *name;

@end
