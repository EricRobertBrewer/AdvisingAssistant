//
//  NSDictionary+setInt.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/20/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (setInt)

-(void)setInt:(int)value forKey:(NSString *)key;
-(void)setValues:(NSDictionary *)other;

@end
