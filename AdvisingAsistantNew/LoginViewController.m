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
@synthesize nextController, stndIDTextField;

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
        ScheduleBuilderViewController *schedule = [[[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[[[Department alloc] init] autorelease]] autorelease];
        stndIDTextField.text = @"";
        [self.navigationController pushViewController:schedule animated:YES];
    }
    
}

- (IBAction)didTapEdit:(id)sender {
}

- (IBAction)didTapSavvy:(id)sender {
    ScheduleBuilderViewController *temp = [[[ScheduleBuilderViewController alloc] init] autorelease];
    stndIDTextField.text = @"";
    [self.navigationController pushViewController:temp animated:YES];
}

- (IBAction)didtapDanny:(id)sender {
    NSArray *semesters = [[NSArray alloc] initWithObjects:@"Fall 2013", @"Spring 2014", @"Fall 2014",
                          @"Spring 2015", @"Fall 2015", @"Spring 2016", @"Fall 2016", @"Spring 2017", nil];
    CourseDetailViewController * temp = [[CourseDetailViewController alloc] initWithCourse:@"CS 355" andUnits:4 andDescription:@"This course is useful. It's also required. Take it or feel the wrath of Ali Kooshesh come down upon you." andSemesters:semesters];
    stndIDTextField.text = @"";
    
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
    [semesters release];
}
@end
