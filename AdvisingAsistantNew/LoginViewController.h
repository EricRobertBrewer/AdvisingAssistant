//
//  LoginViewController.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "StudentRepo.h"
#import "NewStudentViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UITextField *usrnmTextField;
    IBOutlet UITextField *psswrdTextField;
    IBOutlet UITextField *stndIDTextField;
    IBOutlet UIButton *goBttn;
    IBOutlet UIButton *editBttn;
    
    NSString *usrnm, *psswrd;
    int studentID;
    StudentRepo *repo;
}
- (IBAction)didTapGo:(id)sender;
- (IBAction)didTapEdit:(id)sender;

@end
