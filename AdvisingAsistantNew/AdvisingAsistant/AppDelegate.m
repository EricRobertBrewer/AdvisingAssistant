//
//  AppDelegate.m
//  AdvisingAsistant
//
//  Created by student on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize login = _login;
@synthesize navigationController = _navigationController;

- (void)dealloc {
	self.window = nil;
	self.login = nil;
	self.navigationController = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    self.login = [[[LoginViewController alloc] init] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.login] autorelease];
    self.navigationController.navigationItem.backBarButtonItem.title = @"Logout";
    self.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
