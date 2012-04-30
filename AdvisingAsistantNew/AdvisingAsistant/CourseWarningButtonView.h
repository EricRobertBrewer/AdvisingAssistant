//
//  CourseWarningButtonView.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/30/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AANotify.h"
#import "Course.h"

@interface CourseWarningButtonView : UIView {
    
}

@property (nonatomic, retain) NSArray *prereqs, *coreqs;

@end
