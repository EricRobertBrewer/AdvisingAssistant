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
//#import "ScheduleBuilderViewController.h"

@class ScheduleBuilderViewController;

@interface CourseDetailViewController : UIViewController <UITextFieldDelegate>
{
    
    IBOutlet UILabel *lblCourseName;
    IBOutlet UILabel *lblUnits;
    IBOutlet UILabel *lblGrade;
    IBOutlet UITextView *txtCourseDesc;
    IBOutlet UIStepper *semesterStepper;
    IBOutlet UILabel *semesterLabel;
    IBOutlet UIButton *btnAddCourse;
    IBOutlet UIButton *btnMoveCourse;
    IBOutlet UIButton *btnRemoveCourse;
    IBOutlet UIButton *closeView;
    IBOutlet UITextField *customCourseName;
    IBOutlet UITextView *txtCoursePrereqs;
    
    NSArray *prereqs;
}

@property (nonatomic, assign) BOOL addCourse;
@property (nonatomic, retain) Course *currentCourse;
@property (nonatomic, retain) ScheduleBuilderViewController *delegate;
@property (nonatomic, retain) NSMutableArray *semesters;

- (IBAction)addCourseClicked:(id)sender;
- (IBAction)StepperPressed:(id)sender;
- (IBAction)tappedCloseView:(id)sender;
- (IBAction)moveCourseClicked:(id)sender;
- (IBAction)removeCourseClicked:(id)sender;

- (Course *)getCourseFromSemester:(Semester *)semester;
- (Semester *)getSemesterWithCourse;
- (id)initWithCourse:(Course *)course andSemesters:(NSMutableArray *)sems;
- (void)showGrade:(NSString *)grade;

@end
