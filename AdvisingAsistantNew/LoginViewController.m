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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == studentIDTextField) {
        [self didTapGo:(UITextField *)textField];
        return YES;
    }
    return NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [studentIDTextField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    repo = [StudentRepo defaultRepo];
	[studentIDTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [studentIDTextField release];
    studentIDTextField = nil;
    [goBttn release];
    goBttn = nil;
    [editBttn release];
    editBttn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {

    [studentIDTextField release];
    [goBttn release];
    [editBttn release];
    [super dealloc];
}
- (IBAction)didTapGo:(id)sender {
    [studentIDTextField resignFirstResponder];
    
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
        ScheduleBuilderViewController *schedule = [[[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[dRepo departmentWithCode:@"CS"]] autorelease];
        studentIDTextField.text = @"";
        [self.navigationController pushViewController:schedule animated:YES];
    }
    
}

- (IBAction)didTapEdit:(id)sender {
    EditTemplateViewController *modalView = [[[EditTemplateViewController alloc] init] autorelease];
    modalView.parentController = self;
    modalView.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:modalView animated:YES];
}

@end
