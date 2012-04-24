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
        DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
        ScheduleBuilderViewController *schedule = [[[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[dRepo departmentWithCode:@"CS"]] autorelease];
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
    
    Semester *semNum1 = [[Semester alloc] init];
    [semNum1 setDate:SemesterDateMake(SeasonFall, 2013)];
    Semester *semNum2 = [[Semester alloc] init];
    [semNum2 setDate:SemesterDateMake(SeasonSpring, 2014)];
    Semester *semNum3 = [[Semester alloc] init];
    [semNum3 setDate:SemesterDateMake(SeasonFall, 2014)];
    Semester *semNum4 = [[Semester alloc] init];
    [semNum4 setDate:SemesterDateMake(SeasonSpring, 2015)];
    Semester *semNum5 = [[Semester alloc] init];
    [semNum5 setDate:SemesterDateMake(SeasonFall, 2015)];
    Semester *semNum6 = [[Semester alloc] init];
    [semNum6 setDate:SemesterDateMake(SeasonSpring, 2016)];
    Semester *semNum7 = [[Semester alloc] init];
    [semNum7 setDate:SemesterDateMake(SeasonFall, 2016)];
    Semester *semNum8 = [[Semester alloc] init];
    [semNum8 setDate:SemesterDateMake(SeasonSpring, 2017)];
     
    NSArray *semesters = [[NSArray alloc] initWithObjects:semNum1, semNum2, semNum3, semNum4, semNum5, semNum6, semNum7, semNum8, nil];
                          
    Course *CS355 = [[Course alloc] init];
    Department *CompSci = [[Department alloc] init];
    
    // set up the test CS Course
    [CS355 setUnits:4];
    [CS355 setTitle:@"Database Management System Design"];
    [CS355 setDescription:@"This course covers SQL queries, ER Diagrams, Normal Forms, and other Database design stuff."];
    [CS355 setNumber:@"355"];
    CS355.available = AvailabileSpring;
    
    // set department for the course
    [CompSci setName:@"Computer Science"];
    [CompSci setCode:@"CS"];
    [CS355 setDepartment:CompSci];
    
    CourseDetailViewController * temp = [[CourseDetailViewController alloc] initWithCourse:CS355 andSemesters:semesters];
    
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
    [semesters release];
    [CompSci release];
    [CS355 release];
    [semNum1 release];
    [semNum2 release];
    [semNum3 release];
    [semNum4 release];
    [semNum5 release];
    [semNum6 release];
    [semNum7 release];
    [semNum8 release];
}
@end
