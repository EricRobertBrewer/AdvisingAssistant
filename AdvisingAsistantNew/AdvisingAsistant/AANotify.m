//
//  AANotify.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/28/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "AANotify.h"
#import "AppDelegate.h"

@implementation AANotify

+(void)present:(CKNotifyAlertType)type title:(NSString *)title body:(NSString *)body duration:(float)duration {
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	UIView *view = delegate.topView;
	[[CKNotify sharedInstance] presentAlert:type withTitle:title andBody:body inView:view forDuration:duration];
}

@end
