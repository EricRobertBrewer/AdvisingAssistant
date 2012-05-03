//
//  EditTemplateViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/24/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "EditTemplateViewController.h"

@interface EditTemplateViewController ()

@end

@implementation EditTemplateViewController
@synthesize parentController, pickerView1, pickerView2, editedTemplate, D;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithDepartment:(Department *)department {
    if (self = [super init])
    {
        self.D = department;
    }
    return  self;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
        if ([templates count] == 0)
            return 1;
        return [templates count];
    }
    return 2;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
        if ([templates count] == 0)
            return @"";
        Template *temp = [templates objectAtIndex:row];
        return temp.name;
    }
    else if (pickerView == pickerView2)
    {
        if (row == 0)
            return @"Freshmen Pattern";
        return @"Transfer Pattern";
    }
    return @"WRONG PICKERVIEW";
}

- (void) pickerView:(UIPickerView *)pv didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pv == self.pickerView1)
    {
        self.editedTemplate = [templates objectAtIndex:row];
        editTemplateField.text = [self pickerView:pv titleForRow:row forComponent:component];
    }
    else if (pv == self.pickerView2)
    {
        gePatternField.text = [self pickerView:pv titleForRow:row forComponent:component];
    }
}

/*- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
 UILabel *lab;
 if (view)
 lab = (UILabel *)view;
 else
 lab = [[[UILabel alloc] init] autorelease];
 Template *temp = [templates objectAtIndex:row];
 lab.text = temp.name;
 [lab sizeToFit];
 return lab;
 }*/

- (float) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == createTemplateField)
    {
        [createTemplateField resignFirstResponder];
        [self didTapCreate:(UITextField *) textField];
        return YES;
    }
    return  NO;
}

- (void) viewDidDisappear:(BOOL)animated {
    if (submit)
    {
        ScheduleBuilderViewController *nextController = [[[ScheduleBuilderViewController alloc] initWithTemplate:self.editedTemplate] autorelease];
        parentController.nextController = nextController;
        [parentController.navigationController pushViewController:nextController animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    submit = NO;
    TemplateRepo *repo = [TemplateRepo defaultRepo];
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    
    templates = [[repo templatesForDepartment:[dRepo departmentWithCode:self.D.code]] retain];
    if ([templates count] != 0)
        self.editedTemplate = [templates objectAtIndex:0];
    
    self.pickerView1 = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
    self.pickerView1.delegate = self;
    self.pickerView1.dataSource = self;
    self.pickerView1.showsSelectionIndicator = YES;
    
    [self.pickerView1 selectRow:0 inComponent:0 animated:YES];
    editTemplateField.inputView = self.pickerView1;
    editTemplateField.inputView.frame = CGRectMake(0, 0, 100, 100);
    editTemplateField.text = [self pickerView:self.pickerView1 titleForRow:0 forComponent:0];
    
    self.pickerView2 = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
    self.pickerView2.delegate = self;
    self.pickerView2.dataSource = self;
    self.pickerView2.showsSelectionIndicator = YES;
    
    [self. pickerView2 selectRow:0 inComponent:0 animated:YES];
    gePatternField.inputView = self.pickerView2;
    gePatternField.inputView.frame = CGRectMake(0, 0, 100, 100);
    gePatternField.text = [self pickerView:self.pickerView2 titleForRow:0 forComponent:0];
}

- (void)viewDidUnload
{
    [createTemplateField release];
    createTemplateField = nil;
    [editTemplateField release];
    editTemplateField = nil;
    [gePatternField release];
    gePatternField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    self.pickerView1 = nil;
    self.pickerView2 = nil;
    self.editedTemplate = nil;
    self.parentController = nil;
    [createTemplateField release];
    [editTemplateField release];
    [gePatternField release];
    [super dealloc];
}

- (IBAction)didTapEdit:(id)sender {
    if ([editTemplateField.text length] > 0)
    {
        submit = YES;
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)didTapCreate:(id)sender {
    if ([createTemplateField.text length] > 0)
    {
        submit = YES;
        TemplateRepo *repo = [TemplateRepo defaultRepo];
        DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
        
        Template *temp = [[[Template alloc] init] autorelease];
        temp.name = createTemplateField.text;
        temp.department = [dRepo departmentWithCode:@"CS"];
        if ([gePatternField.text isEqualToString:@"Freshman Pattern"])
            temp.pattern = GEPatternFreshman;
        else if ([gePatternField.text isEqualToString:@"Transfer Pattern"])
            temp.pattern = GEPatternTransfer;
        
        [repo saveTemplate:temp];
        self.editedTemplate = [repo templateForName:temp.name inDepartment:temp.department];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)didTapDelete:(id)sender {
    if ([editTemplateField.text length] <= 0)
        return;
    TemplateRepo *repo = [TemplateRepo defaultRepo];
    [repo deleteTemplate:self.editedTemplate];
    [templates release];
    templates = [[repo allTemplates] retain];
    [self.pickerView1 reloadAllComponents];
    [self.pickerView1 selectRow:0 inComponent:0 animated:YES];
    editTemplateField.text = [self pickerView:self.pickerView1 titleForRow:0 forComponent:0];
    if ([templates count] != 0)
        self.editedTemplate = [templates objectAtIndex:0];
    else
        self.editedTemplate = nil;
}

- (IBAction)didTapExit:(id)sender {
    submit = NO;
    [self dismissModalViewControllerAnimated:YES];
}
@end
