//
//  LoginViewController.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentRepo.h"
#import "NewStudentViewController.h"
#import "EditTemplateViewController.h"
//#import "ScheduleBuilderViewController.h"
#import "CourseDetailViewController.h"
#import "TemplateRepo.h"
#import "DepartmentRepo.h"

@class ScheduleBuilderViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
    IBOutlet UITextField *studentIDTextField;
    IBOutlet UIButton *goBttn;
    IBOutlet UIButton *editBttn;
    IBOutlet UITextField *departmentField;

    int studentID;
    StudentRepo *repo;
    ScheduleBuilderViewController * nextController;
}

@property (nonatomic, retain) ScheduleBuilderViewController *nextController;
@property (nonatomic, retain) IBOutlet UITextField *studentIDTextField;

- (IBAction)didTapGo:(id)sender;
- (IBAction)didTapEdit:(id)sender;

@end
