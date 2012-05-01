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
#import "CourseWarningButtonView.h"
//#import "ScheduleBuilderViewController.h"

@class ScheduleBuilderViewController;

@interface CourseDetailViewController : UIViewController <UITextFieldDelegate>
{
    
    IBOutlet UILabel *lblCourseName;
    IBOutlet UILabel *lblUnits;
    IBOutlet UILabel *lblCoreqs;
    IBOutlet UITextView *txtCourseDesc;
    IBOutlet UIStepper *semesterStepper;
    IBOutlet UILabel *semesterLabel;
    IBOutlet UIButton *btnAddCourse;
    IBOutlet UIButton *btnMoveCourse;
    IBOutlet UIButton *btnRemoveCourse;
    IBOutlet UIButton *closeView;
    IBOutlet UITextField *customCourseName;
    IBOutlet UITextView *txtCoursePrereqs;
    
    int semesterIndexInArray;
    
}

@property (nonatomic, assign) BOOL addCourse;
@property (nonatomic, retain) Course *currentCourse;
@property (nonatomic, retain) ScheduleBuilderViewController *delegate;
@property (nonatomic, retain) NSArray *prereqs;
@property (nonatomic, retain) NSArray *coreqs;
@property (nonatomic, retain) NSMutableArray *semesters;
@property (nonatomic, retain) CourseWarningButtonView *cwbv;
@property (nonatomic, assign) SemesterDate semesterDate;

- (IBAction)addCourseClicked:(id)sender;
- (IBAction)StepperPressed:(id)sender;
- (IBAction)tappedCloseView:(id)sender;
- (IBAction)moveCourseClicked:(id)sender;
- (IBAction)removeCourseClicked:(id)sender;

- (BOOL)shouldShowWarning:(SemesterDate)sd;
- (Semester *)getSemesterWithDate:(SemesterDate)sd;
- (Course *)getCourseFromSemester:(Semester *)semester;
- (Semester *)getSemesterWithCourse;
- (id)initWithCourse:(Course *)course andSemesters:(NSMutableArray *)sems;

@end
