//
//  Repo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/11/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "Repo.h"

@implementation Repo
@synthesize error;

-(void)dealloc {
	self.error = nil;
	[super dealloc];
}

// Singleton stuff

+(id)allocWithZone:(NSZone *)zone {
	assert(0); // Not sure what "Zone" methods do
}
-(id)copyWithZone:(NSZone *)zone {
	assert(0);
}

-(id)retain {
	return self;
}

-(unsigned)retainCount {
	return UINT_MAX;
}

-(oneway void)release {
	// do nothing
}

-(id)autorelease {
	return self;
}

@end
