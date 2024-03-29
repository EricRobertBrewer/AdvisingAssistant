//
//  NewStudentViewController.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Student.h"
//#import "StudentRepo.h"
//#import "ScheduleBuilderViewController.h"
//#import "Department.h"
#import "LoginViewController.h"


@class LoginViewController;
@class Template;
@class Department;

@interface NewStudentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    int studentID;
    Department *D;
    IBOutlet UITextField *studentIDField;
    IBOutlet UITextField *studentName;
    IBOutlet UITextField *semesterStarted;
    IBOutlet UITextField *templateField;
    IBOutlet UITextField *GEPatternField;
    
    UIPickerView *pickerView1, *pickerView2, *pickerView3;
    BOOL submit;
}

@property (nonatomic, retain) NSArray *templates;
@property (nonatomic, retain) NSMutableArray *freshmenTemplates, *transferTemplates;
@property (nonatomic, retain) NSString *year, *season;
@property (nonatomic, retain) Template *T;
@property (nonatomic, retain) LoginViewController *parentController;

- (id) initWithStudentID: (int)ID andDepartment:(Department *)department;
- (IBAction)didTapSubmit:(id)sender;
- (IBAction)didTapExit:(id)sender;

@end