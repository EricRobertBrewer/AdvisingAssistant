//
//  Repo.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/11/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectOptions.h"

// Base class for all repositories
// Provides singleton stuff

@interface Repo : NSObject

-(id)connect:(ConnectOptions*)options;

@property (nonatomic, retain) NSString *error;

@end
