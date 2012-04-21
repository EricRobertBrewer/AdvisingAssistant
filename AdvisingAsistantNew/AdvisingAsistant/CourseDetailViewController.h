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
    NSString *courseName;
    int localUnits;
    NSString *description;
}
@property (atomic, retain) NSMutableArray *semesters;

- (IBAction)addCourseClicked:(id)sender;
- (IBAction)StepperPressed:(id)sender;

- (id)initWithCourse:(NSString *)course andUnits:(int)units andDescription:(NSString *)desc andSemesters:(NSArray *)sems;
- (void)setGrade:(NSString *)grade;

@end
