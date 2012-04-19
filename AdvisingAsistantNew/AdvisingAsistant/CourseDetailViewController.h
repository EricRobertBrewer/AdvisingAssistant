//
//  CourseDetailViewController.h
//  AdvisingAssistant
//
//  Created by Daniel DePaolo on 4/6/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
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
    
    NSMutableArray *semesters;
    int numSemesters;
    NSString *courseName;
}
@property (atomic, retain) NSMutableArray *semesters;

- (IBAction)addCourseClicked:(id)sender;
- (IBAction)StepperPressed:(id)sender;

- (id)initWithCourse:(NSString *)course;

@end
