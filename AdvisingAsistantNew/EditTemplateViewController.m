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
@synthesize parentController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [templates count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [templates objectAtIndex:row];;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    editTemplateField.text = [self pickerView:pickerView titleForRow:row forComponent:component];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    submit = NO;
    TemplateRepo *repo = [TemplateRepo defaultRepo];
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    
    templates = [[repo templatesForDepartment:[dRepo departmentWithCode:@"CS"]] retain];
    
    UIPickerView *pickerView = [[[UIPickerView alloc] init] autorelease];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    [pickerView selectRow:0 inComponent:0 animated:YES];
    editTemplateField.inputView = pickerView;
    editTemplateField.text = [self pickerView:pickerView titleForRow:0 forComponent:0];
}

- (void)viewDidUnload
{
    [createTemplateField release];
    createTemplateField = nil;
    [editTemplateField release];
    editTemplateField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [createTemplateField release];
    [editTemplateField release];
    [super dealloc];
}

- (IBAction)didTapEdit:(id)sender {
   if ([editTemplateField.text length] > 0 && [templates containsObject:editTemplateField.text])
   {
       submit = YES;
   }
}

- (IBAction)didTapCreate:(id)sender {
    if ([createTemplateField.text length] > 0)
    {
        submit = YES;
    }
}

- (IBAction)didTapExit:(id)sender {
    submit = NO;
    [self dismissModalViewControllerAnimated:YES];
}
@end
