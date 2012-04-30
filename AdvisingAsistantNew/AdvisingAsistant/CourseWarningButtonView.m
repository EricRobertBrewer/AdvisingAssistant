//
//  CourseWarningButtonView.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/30/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "CourseWarningButtonView.h"

@implementation CourseWarningButtonView
@synthesize prereqs, coreqs;

- (void)didTapWarning:(id) selector {
    if ([prereqs count] != 0)
        [AANotify present:CKNotifyAlertTypeInfo title:@"a string that I am going to set" body:@"a string that I'm going to set" duration:5];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(didTapWarning:) forControlEvents:UIControlEventTouchDown];
        button.imageView.image = [UIImage imageNamed:@"warning"];
        [self addSubview:button];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
