//
//  ConnectOptions.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/18/12.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectOptions : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSDictionary *getData;
@property (nonatomic, retain) NSDictionary *postData;

+(ConnectOptions *)optionsWithUrl:(NSString *)url;

@end
