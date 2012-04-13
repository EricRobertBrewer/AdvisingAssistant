//
//  CourseDetailViewController.h
//  AdvisingAssistant
//
//  Created by Kirsten Helgeson on 4/6/12.
//  Copyright (c) 2012 University of California, Los Angeles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailViewController : UIViewController
{
    
    IBOutlet UILabel *lblCourseName;
    IBOutlet UILabel *lblUnits;
    IBOutlet UILabel *lblGrade;
    IBOutlet UITextView *txtCourseDesc;
    IBOutlet UIStepper *semesterStepper;
    IBOutlet UILabel *semesterLabel;
    IBOutlet UIButton *btnAddCourse;
}
- (IBAction)addCourseClicked:(id)sender;

@end
