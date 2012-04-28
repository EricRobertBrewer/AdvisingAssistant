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
    IBOutlet UITextField *gePatternField;
    
    NSArray *templates;
    BOOL submit;
    Template *editedTemplate;
}

@property (nonatomic, retain) LoginViewController  *parentController;
@property (nonatomic, retain) UIPickerView *pickerView1, *pickerView2;
@property (nonatomic, retain) Template *editedTemplate;

- (IBAction)didTapEdit:(id)sender;
- (IBAction)didTapCreate:(id)sender;
- (IBAction)didTapDelete:(id)sender;
- (IBAction)didTapExit:(id)sender;

@end
