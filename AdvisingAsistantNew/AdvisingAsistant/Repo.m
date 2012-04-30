//
//  Repo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/11/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "Repo.h"
#import "ASIHttpRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "AANotify.h"

@implementation Repo
@synthesize error = _error;

-(void)dealloc {
	self.error = nil;
	[super dealloc];
}

-(NSString *)urlEncode:(NSString *)input {
	return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
															   (CFStringRef)self,
															   NULL,
															   (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
															   CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

-(NSURL*)getUrl:(ConnectOptions*)options {
	NSString *url = [NSString stringWithFormat:@"http://moonlight.cs.sonoma.edu/ebrewer/%@", options.url];
	NSString *separator = @"?";
	for (NSString *key in [options.getData allKeys]) {
		NSString *value = [self urlEncode:[options.getData objectForKey:key]];
		key = [self urlEncode:key];
		url = [url stringByAppendingFormat:@"%@%@=%@", separator, key, value];
		separator = @"&";
	}
    NSLog(@"Sending request to URL: %@", url);
	return [NSURL URLWithString:url];
}

-(ASIHTTPRequest*)getRequest:(ConnectOptions*)options {
	NSURL *url = [self getUrl:options];
    if ([options.postData count] > 0) {
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        for (NSString *key in options.postData.allKeys) {
            NSString *value = [options.postData objectForKey:key];
            [request setPostValue:value forKey:key];
            NSLog(@"Request Post Data [%@=%@]", key, value);
        }
        return request;
    }
	return [ASIHTTPRequest requestWithURL:url];
}

-(id)connect:(ConnectOptions *)options {
	ASIHTTPRequest *request = [self getRequest:options];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		self.error = nil;
        NSString *response = [request responseString];
        NSLog(@"Got Response: %@", response);
		id json = [response JSONValue];
		if (json) {
			return json;
		} else {
			self.error = response;
		}
	} else {
		self.error = error.description;
	}
	[AANotify present:CKNotifyAlertTypeError title:@"Server Error" body:self.error duration:4];
	return nil;
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
