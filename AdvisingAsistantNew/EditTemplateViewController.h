//
//  EditTemplateViewController.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/24/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ScheduleBuilderViewController.h"

@class Template;
@class LoginViewController;

@interface EditTemplateViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
    IBOutlet UITextField *createTemplateField;
    IBOutlet UITextField *editTemplateField;
    
    NSArray *templates;
    LoginViewController *parentController;
    BOOL submit;
    Template *editedTemplate;
}

@property (nonatomic, retain) LoginViewController  *parentController;

- (IBAction)didTapEdit:(id)sender;
- (IBAction)didTapCreate:(id)sender;
- (IBAction)didTapDelete:(id)sender;
- (IBAction)didTapExit:(id)sender;

@end
