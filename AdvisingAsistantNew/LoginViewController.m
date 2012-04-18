//
//  LoginViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usrnmTextField) {
        usrnm = usrnmTextField.text;
        [psswrdTextField becomeFirstResponder];
        return YES;
    }
    else if (textField == psswrdTextField) {
        [stndIDTextField becomeFirstResponder];
        psswrd = psswrdTextField.text;
        return YES;
    }
    if (textField == stndIDTextField) {
        [self didTapGo:(UITextField *)textField];
        return YES;
    }
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    repo = [StudentRepo defaultRepo];
}

- (void)viewDidUnload
{
    [usrnmTextField release];
    usrnmTextField = nil;
    [psswrdTextField release];
    psswrdTextField = nil;
    [stndIDTextField release];
    stndIDTextField = nil;
    [goBttn release];
    goBttn = nil;
    [editBttn release];
    editBttn = nil;
    [savvyButtn release];
    savvyButtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [usrnmTextField release];
    [psswrdTextField release];
    [stndIDTextField release];
    [goBttn release];
    [editBttn release];
    
    [savvyButtn release];
    [super dealloc];
}
- (IBAction)didTapGo:(id)sender {
    [usrnmTextField resignFirstResponder];
    [psswrdTextField resignFirstResponder];
    [stndIDTextField resignFirstResponder];
    
    if ([stndIDTextField.text length] <= 0)
        return;
    
    NSLog(@"User did tap go.\n");
    studentID = [stndIDTextField.text intValue];
    Student *temp = [repo studentWithId:studentID];
    if (temp == nil)
    {
        if (repo.error == nil)
        {
            [self.navigationController pushViewController:[[[NewStudentViewController alloc] initWithStudentID:studentID] autorelease]  animated:YES];
        }
        else
        {
            NSLog(@"%@", repo.error);
        }
    }
    else
    {
        ScheduleBuilderViewController *schedule = [[[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[[[Department alloc] init] autorelease]] autorelease];
        [self.navigationController pushViewController:schedule animated:YES];
    }
    
}

- (IBAction)didTapEdit:(id)sender {
}

- (IBAction)didTapSavvy:(id)sender {
    ScheduleBuilderViewController *temp = [[[ScheduleBuilderViewController alloc] init] autorelease];
    [self.navigationController pushViewController:temp animated:YES];
}

- (IBAction)didtapDanny:(id)sender {
    CourseDetailViewController * temp = [[[CourseDetailViewController alloc] init] autorelease];
    [self.navigationController pushViewController:temp animated:YES];
    
}
@end
