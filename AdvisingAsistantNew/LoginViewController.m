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
@synthesize nextController, departments, studentIDTextField, currentDepartment;

- (void)dealloc
{
    [studentIDTextField release];
    [goBttn release];
    [editBttn release];
    [departmentField release];
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
    
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    Department *temp1 = [dRepo departmentWithCode:@"CS"];
    Department *temp2 = [dRepo departmentWithCode:@"ES"];
    self.departments = [[NSArray alloc] initWithObjects:temp1, temp2, nil];
    
    UIPickerView *pickerView = [UIPickerView new];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    
    departmentField.inputView = pickerView;
    departmentField.inputView.frame = CGRectMake(0, 0, 550, 100);
    departmentField.text = [self pickerView:pickerView titleForRow:0 forComponent:0];
    self.currentDepartment = [departments objectAtIndex:0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)didTapGo:(id)sender
{
    if ([studentIDTextField.text length] <= 0 && [departmentField.text length] <=0)
        return;
    
    NSLog(@"User did tap go.\n");
    studentID = [studentIDTextField.text intValue];
    Student *temp = [repo studentWithId:studentID];
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    if (temp == nil)
    {
        if (repo.error == nil)
        {
            NewStudentViewController *modalView = [[[NewStudentViewController alloc] initWithStudentID:studentID andDepartment:[dRepo departmentWithCode:self.currentDepartment.code]] autorelease];
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
        ScheduleBuilderViewController *schedule = [[ScheduleBuilderViewController alloc] initWithStudent:temp andDepartment:[dRepo departmentWithCode:self.currentDepartment.code]];
        studentIDTextField.text = @"";
        [self.navigationController pushViewController:schedule animated:YES];
		[schedule release];
    }
    
}

-(float) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 500;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.departments count] == 0)
        return 1;
    return [self.departments count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.departments count] == 0)
        return @"";
    Department *temp = [self.departments objectAtIndex:row];
    return temp.name;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    departmentField.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    self.currentDepartment = [self.departments objectAtIndex:row];
}


- (IBAction)didTapEdit:(id)sender
{
    if ([departmentField.text length] <= 0)
        return;
    
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    EditTemplateViewController *modalView = [[[EditTemplateViewController alloc] initWithDepartment:[dRepo departmentWithCode:self.currentDepartment.code]] autorelease];
    modalView.parentController = self;
    modalView.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:modalView animated:YES];
}

- (void)viewDidUnload {
    [departmentField release];
    departmentField = nil;
    [super viewDidUnload];
}
@end
