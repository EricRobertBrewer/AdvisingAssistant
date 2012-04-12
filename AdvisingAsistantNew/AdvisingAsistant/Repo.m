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


-(id)copyWithZone:(NSZone *)zone {
	return self;
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
