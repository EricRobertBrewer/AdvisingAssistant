//
//  AppDelegate.h
//  AdvisingAsistant
//
//  Created by student on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIViewController *login;
@property (nonatomic, retain) UINavigationController *navigationController;

-(UIView *)topView;

@end
