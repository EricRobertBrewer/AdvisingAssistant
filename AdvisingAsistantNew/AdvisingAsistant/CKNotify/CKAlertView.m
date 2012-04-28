//
//  CKAlertView.m
//  cknotify
//
//  Created by Matthew Schettler on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CKAlertView.h"
#import "CKNotify.h"


@implementation CKAlertView
@synthesize uniqueID, selectorTarget, onTapSelector, selectorObject, myLocation, inView;


- (id)init {
    
    if (!(self = [super init])) return nil;

    self.uniqueID = [NSString stringWithFormat:@"%p", self];
//    NSLog(@"new alert with uniqueID = %@", self.uniqueID);
    isDismissing = NO;
    
    extraDuration = 0.0;
    
    // set default action on tap to dismiss the alert
    tapSelector = @selector(autoDismissMe);
    tapTarget = self;
    
    leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
        
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMe:)];
    [self.view addGestureRecognizer:tap];
    
    return self;
}


- (void)setTitle:(NSString *)title withBody:(NSString *)body andType:(CKNotifyAlertType)type {
    
    assert(lblTitle && lblBody);
    
    // if they gave a body and no title, switch 'em
    if (body && !title) {
        title = body;
        body = nil;
    }

    lblBody.text = body;
    lblTitle.text = title;
    
    switch (type) {
        case CKNotifyAlertTypeSuccess:
            // to-do finish success type
            imgViewBackround.image = [[UIImage imageNamed:@"CKGreenPanel"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            imgViewIcon.image = [UIImage imageNamed:@"CKTickIcon"];
            lblTitle.font = [UIFont boldSystemFontOfSize:15];
            lblBody.textColor = RGBA(235, 235, 235, 1.0);
            lblBody.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
            break;
        case CKNotifyAlertTypeInfo:
            imgViewBackround.image = [[UIImage imageNamed:@"CKBluePanel"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            imgViewIcon.image = [UIImage imageNamed:@"CKInfoIcon"];
            lblTitle.font = [UIFont boldSystemFontOfSize:15];
            lblBody.textColor = RGBA(210, 210, 235, 1.0);
            break;
        case CKNotifyAlertTypeError:
            imgViewBackround.image = [[UIImage imageNamed:@"CKRedPanel.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            imgViewIcon.image = [UIImage imageNamed:@"CKWarningIcon"];
            imgViewIcon.alpha = 0.9;
            lblBody.textColor = [UIColor colorWithRed:1.0 green:0.651f blue:0.651f alpha:1.0];
            lblTitle.font = [UIFont boldSystemFontOfSize:15];
            lblBody.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
            break;
        default:
            assert(0); // impossible case
    }
    
    assert(imgViewBackround.image);
    assert(imgViewIcon.image);
        
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        // iPhone/iPod
        const CGFloat panelHeight = 60;
        self.view.frame = CGRectMake(0, self.view.frame.origin.y, 320, panelHeight);
        lblBody.frame = CGRectMake(57, 19, 253, 38);
        lblTitle.frame = CGRectMake(57, 1, 253, 21);
        // fixme if body only has one line, adjust title label down slightly
    }

    if (!lblBody.text.length) {
        // no body text
        lblBody.hidden = YES;
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            // iPhone/iPod
            lblTitle.center = CGPointMake(lblTitle.center.x, (self.view.frame.size.height / 2) - 2);
        } else {
            // iPad
            lblTitle.center = CGPointMake(lblTitle.center.x, (self.view.frame.size.height / 2) - 4);
        }
    }

}


- (void)autoDismissMe {
    
    // if extraDuration is non-zero, this alert still has some life in it
    if (extraDuration > 0.9) {
//        NSLog(@"obeying extraDuration of %.1f", extraDuration);
        [self performSelector:@selector(autoDismissMe) withObject:nil afterDelay:extraDuration];
        extraDuration = 0.0;
        return;
    }
    
//    NSLog(@"dismissing...");
    
    self.view.userInteractionEnabled = NO; // prevent any actions on this alert once its been told to dismiss
    isDismissing = YES;
    [self.view removeGestureRecognizer:leftSwipe];
    [self.view removeGestureRecognizer:rightSwipe];
    [self.view removeGestureRecognizer:tap];
    [[CKNotify sharedInstance] dismissAlert:self];
}


#pragma mark SwipeSelectors

- (void)didSwipeLeft:(id)sender {
    
    if (swipeLeftTarget && [swipeLeftTarget respondsToSelector:swipeLeftSelector] && !isDismissing) {
        if (swipeLeftObject) {
            [swipeLeftTarget performSelector:swipeLeftSelector withObject:swipeLeftObject];
        } else {
            [swipeLeftTarget performSelector:swipeLeftSelector];
        }
        if (swipeLeftSelector != @selector(autoDismissMe)) extraDuration = 1.1;
    }
    
}


- (void)didSwipeRight:(id)sender {
    
    if (swipeRightTarget && [swipeRightTarget respondsToSelector:swipeRightSelector] && !isDismissing) {
        if (swipeRightObject) {
            [swipeRightTarget performSelector:swipeRightSelector withObject:swipeRightObject];
        } else {
            [swipeRightTarget performSelector:swipeRightSelector];
        }
        if (swipeRightSelector != @selector(autoDismissMe)) extraDuration = 1.1;
    }
    
}


- (void)didTapMe:(id)sender {
    
    if (tapTarget && [tapTarget respondsToSelector:tapSelector] && !isDismissing) {
        if (tapObject) {
            [tapTarget performSelector:tapSelector withObject:tapObject];
        } else {
            [tapTarget performSelector:tapSelector];
        }
        if (tapSelector != @selector(autoDismissMe)) extraDuration = 1.1;
    }
    
}


- (void)setSwipeRightAction:(SEL)selector onTarget:(id)target withObject:(id)obj {
    
    if (selector) assert(target);
    if (target) assert(selector);
    
    swipeRightSelector = selector;
    swipeRightTarget = target;
    swipeRightObject = obj;
    
}


- (void)setSwipeLeftAction:(SEL)selector onTarget:(id)target withObject:(id)obj {
    
    if (selector) assert(target);
    if (target) assert(selector);
    
    swipeLeftSelector = selector;
    swipeLeftTarget = target;
    swipeLeftObject = obj;
    
}


- (void)setTapAction:(SEL)selector onTarget:(id)target withObject:(id)obj {
    
    if (selector) assert(target);
    if (target) assert(selector);
    
    tapSelector = selector;
    tapTarget = target;
    tapObject = obj;
    
}

#pragma mark Memory

- (void)dealloc {
//    NSLog(@"CKAlertView dealloc()");
    [imgViewBackround release];
    [imgViewIcon release];
    [lblTitle release];
    [lblBody release];
    [leftSwipe release];
    [rightSwipe release];
    [tap release];
    [uniqueID release];
    [inView release];
    [super dealloc];
}


- (void)viewDidUnload {
    [imgViewBackround release];
    imgViewBackround = nil;
    [imgViewIcon release];
    imgViewIcon = nil;
    [lblTitle release];
    lblTitle = nil;
    [lblBody release];
    lblBody = nil;
    [super viewDidUnload];
}

@end

