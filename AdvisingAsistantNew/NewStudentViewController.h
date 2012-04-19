//
//  NewStudentViewController.h
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "StudentRepo.h"
#import "ScheduleBuilderViewController.h"

@interface NewStudentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    int studentID;
    IBOutlet UITextField *studentIDField;
    IBOutlet UITextField *studentName;
    IBOutlet UITextField *semesterStarted;
}

@property (nonatomic, retain) NSString *year, *season;

- (id) initWithStudentID: (int) ID;
- (IBAction)didTapSubmit:(id)sender;

@end
