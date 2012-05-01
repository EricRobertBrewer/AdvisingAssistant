//
//  LoginViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "LoginViewController.h"
#import "ScheduleBuilderViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize nextController, studentIDTextField;

- (void)dealloc
{
    [studentIDTextField release];
    [goBttn release];
    [editBttn release];
    self.nextController = nil;
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == studentIDTextField) {
        [self didTapGo:(UITextField *)textField];
    }
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    repo = [StudentRepo defaultRepo];
	[studentIDTextField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)didTapGo:(id)sender
{
    if ([studentIDTextField.text length] <= 0)
        return;
    
    NSLog(@"User did tap go.\n");
    studentID = [studentIDTextField.text intValue];
    Student *temp = [repo studentWithId:studentID];
    if (temp == nil)
    {
        if (repo.error == nil)
        {
            NewStudentViewController *modalView = [[[NewStudentViewController alloc] initWithStudentID:studentID] autorelease];
            modalView.parentController = self;
            modalView.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentModalViewController:modalView animated:YES];
        }
        else
        {
            NSLog(@"%@", repo.error);
        }
    }
    else
    {
        DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
        ScheduleBuilderViewController *schedule = [[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[dRepo departmentWithCode:@"CS"]];
        studentIDTextField.text = @"";
        [self.navigationController pushViewController:schedule animated:YES];
		[schedule release];
    }
    
}

- (IBAction)didTapEdit:(id)sender
{
    EditTemplateViewController *modalView = [[[EditTemplateViewController alloc] init] autorelease];
    modalView.parentController = self;
    modalView.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:modalView animated:YES];
}

@end
