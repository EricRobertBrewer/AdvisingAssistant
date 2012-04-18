//
//  ConnectOptions.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/18/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "ConnectOptions.h"

@implementation ConnectOptions
@synthesize url = _url;
@synthesize getData = _getData;
@synthesize postData = _postData;

-(void)dealloc {
	self.url = nil;
	self.getData = nil;
	self.postData = nil;
	[super dealloc];
}

-(id)init {
	if ((self = [super init])) {
		self.getData = [NSDictionary dictionary];
		self.postData = [NSDictionary dictionary];
	}
	return self;
}

+(ConnectOptions *)optionsWithUrl:(NSString *)url {
	ConnectOptions *options = [[ConnectOptions alloc] init];
	options.url = url;
	return [options autorelease];
}

@end
