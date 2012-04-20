//
//  Department.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Department : NSObject

@property (nonatomic, retain) NSString *code; // eg CS
@property (nonatomic, retain) NSString *name; // eg Computer Science

-(BOOL)isEqualToDepartment:(Department*)department;

@end
