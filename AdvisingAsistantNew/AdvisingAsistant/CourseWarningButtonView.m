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
    {
        Course *t = [prereqs objectAtIndex:0];
        NSString *courses = t.name;
        for (int i = 1; i < [prereqs count]; i++)
        {
            if (i != [prereqs count]-1)
                courses = [courses stringByAppendingString:@", "];
            t = [prereqs objectAtIndex:i];
            courses = [courses stringByAppendingString:t.name];
        }
        [AANotify present:CKNotifyAlertTypeInfo title:@"Prerequisits not met" body:[NSString stringWithFormat:@"Courses required:%@",courses] duration:5];
    }
    
    if ([coreqs count] != 0)
    {
        Course *t = [coreqs objectAtIndex:0];
        NSString *courses = t.name;
        for (int i = 1; i < [coreqs count]; i++)
        {
            if (i != [coreqs count]-1)
                courses = [courses stringByAppendingString:@", "];
            t = [coreqs objectAtIndex:i];
            courses = [courses stringByAppendingString:t.name];
        }
        [AANotify present:CKNotifyAlertTypeInfo title:@"Corequisits not met" body:[NSString stringWithFormat:@"Courses required:%@",courses] duration:5];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(didTapWarning:) forControlEvents:UIControlEventTouchDown];
        [button setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
