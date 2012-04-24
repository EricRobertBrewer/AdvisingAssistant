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
//#import "ScheduleBuilderViewController.h"
#import "CourseDetailViewController.h"
#import "TemplateRepo.h"
#import "DepartmentRepo.h"

@class ScheduleBuilderViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UITextField *usrnmTextField;
    IBOutlet UITextField *psswrdTextField;
    IBOutlet UITextField *stndIDTextField;
    IBOutlet UIButton *goBttn;
    IBOutlet UIButton *editBttn;
    IBOutlet UIButton *savvyButtn;
    
    NSString *usrnm, *psswrd;
    int studentID;
    StudentRepo *repo;
    ScheduleBuilderViewController * nextController;
}

@property (nonatomic, retain) ScheduleBuilderViewController *nextController;
@property (nonatomic, retain) IBOutlet UITextField *stndIDTextField;

- (IBAction)didTapGo:(id)sender;
- (IBAction)didTapEdit:(id)sender;
- (IBAction)didTapSavvy:(id)sender;
- (IBAction)didtapDanny:(id)sender;

@end
