//
//  CourseDetailViewController.h
//  AdvisingAssistant
//
//  Created by Daniel DePaolo on 4/6/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "SemesterRepo.h"
#import "Student.h"
#import "Semester.h"
#import "Department.h"

@interface CourseDetailViewController : UIViewController
{
    
    IBOutlet UILabel *lblCourseName;
    IBOutlet UILabel *lblUnits;
    IBOutlet UILabel *lblGrade;
    IBOutlet UITextView *txtCourseDesc;
    IBOutlet UIStepper *semesterStepper;
    IBOutlet UILabel *semesterLabel;
    IBOutlet UIButton *btnAddCourse;
    IBOutlet UIButton *closeView;
    
    NSMutableArray *semesters;
    Course *currentCourse;
    
    /*
    UIImageView *iconPicView;
    UIImage *iconPic;
     */
}
@property (atomic, retain) NSMutableArray *semesters;

- (IBAction)addCourseClicked:(id)sender;
- (IBAction)StepperPressed:(id)sender;
- (IBAction)tappedCloseView:(id)sender;

- (id)initWithCourse:(Course *)course andSemesters:(NSArray *)sems;
- (void)showGrade:(NSString *)grade;

@end
