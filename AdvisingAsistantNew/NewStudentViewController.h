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
#import "TemplateRepo.h"

@class LoginViewController;

@interface NewStudentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    int studentID;
    IBOutlet UITextField *studentIDField;
    IBOutlet UITextField *studentName;
    IBOutlet UITextField *semesterStarted;
    IBOutlet UITextField *templateField;
    
    UIPickerView *pickerView1, *pickerView2;
    NSArray *templates;
    LoginViewController *parentController;
}

@property (nonatomic, retain) NSString *year, *season;
@property (nonatomic, retain) Template *T;
@property (nonatomic, retain) LoginViewController *parentController;

- (id) initWithStudentID: (int) ID;
- (IBAction)didTapSubmit:(id)sender;

@end
