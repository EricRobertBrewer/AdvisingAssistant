//
//  CKNotify.h
//  cknotify
//
//  Created by Matthew Schettler on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Version: 1.1
//  Don't forget to    #import "CKNotify.h"    in your .pch file


#import <Foundation/Foundation.h>
#import "CKAlertView.h"

@interface CKNotify : NSObject {
    
    NSMutableDictionary *currentAlerts;
    NSMutableArray *currentAlertsOrdered;
    
}


// Generate an alert. The most commonly used function of the library. Will appear from the top
- (CKAlertView *)presentAlert:(CKNotifyAlertType)type 
                    withTitle:(NSString *)title
                      andBody:(NSString *)body 
                       inView:(UIView *)view 
                  forDuration:(float)duration;




// Generate an alert with an location argument, EX present an alert from the bottom of the view
- (CKAlertView *)presentAlert:(CKNotifyAlertType)type 
                    withTitle:(NSString *)title
                      andBody:(NSString *)body 
                       inView:(UIView *)view 
                  forDuration:(float)duration
                 fromLocation:(CKNotifyAlertLocation)location;







// Do not call any of these manually, they are used internally.
- (void)showAlert:(CKAlertView *)alert usingView:(UIView *)view forDuration:(float)duration;
- (void)dismissAlert:(CKAlertView *)alert;
+ (CKNotify *)sharedInstance;


@end
