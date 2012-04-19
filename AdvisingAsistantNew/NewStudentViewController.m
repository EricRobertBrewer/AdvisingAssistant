//
//  NewStudentViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "NewStudentViewController.h"
#import "LoginViewController.h"
#import "ScheduleBuilderViewController.h"

@implementation NewStudentViewController
@synthesize season, year, parentController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithStudentID:(int)ID {
    self = [super init];
    if (self) {
        studentID = ID;
    }
    return self;
}

- (IBAction)didTapSubmit:(id)sender {
    if ([studentName.text length] > 0 && [studentIDField.text length] > 0 && [semesterStarted.text length] > 0)
    {
        Student * stud = [[[Student alloc] init] autorelease];
        stud.name = studentName.text;
        stud.id = [studentIDField.text intValue];
        Season t = (season == @"Fall") ? SeasonFall: SeasonSpring;
        stud.started = SemesterDateMake(t, [year intValue]);
        
        StudentRepo *repo = [StudentRepo defaultRepo];
        [repo saveStudent:stud];
        if (repo.error != nil)
        {
            NSLog(@"%@", repo.error);
            return;
        }
        
        ScheduleBuilderViewController *temp = [[[ScheduleBuilderViewController alloc] initWithStudent:stud andDepartment:[[[Department alloc] init] autorelease]] autorelease];
        parentController.nextController = temp;
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void) viewDidDisappear:(BOOL)animated {
    parentController.stndIDTextField.text = @"";
    [parentController.navigationController pushViewController:parentController.nextController animated:YES];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return 2;
    return 50;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0)
    {
        if (row == 0)
            return @"Fall";
        else
            return @"Spring";
    }
    else
        return [NSString stringWithFormat:@"%d", row+2000];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1)
        self.year = [self pickerView:pickerView titleForRow:row forComponent:component];
    else
        self.season = [self pickerView:pickerView titleForRow:row forComponent:component];
    semesterStarted.text = [NSString stringWithFormat:@"%@ %@", self.season, self.year];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    studentIDField.text = [NSString stringWithFormat:@"%d", studentID];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSYearCalendarUnit fromDate:[NSDate date]];
    int yearRow = [components year] - 2000;
    int seasonRow = 0;
    
    [pickerView selectRow:yearRow inComponent:1 animated:YES];
    self.year = [self pickerView:pickerView titleForRow:yearRow forComponent:1];
    self.season = [self pickerView:pickerView titleForRow:seasonRow forComponent:0];
    semesterStarted.inputView = pickerView;
    semesterStarted.text = [NSString stringWithFormat:@"%@ %@", season, year];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == studentIDField) {
        [studentName becomeFirstResponder];
        return YES;
    }
    else if (textField == studentName) {
        [semesterStarted becomeFirstResponder];
        return YES;
    }
    if (textField == semesterStarted) {
        [self didTapSubmit:(UITextField *)textField];
        return YES;
    }
    return NO;
}


- (void)viewDidUnload
{
    [studentName release];
    studentName = nil;
    [semesterStarted release];
    semesterStarted = nil;
    [studentIDField release];
    studentIDField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [studentName release];
    [semesterStarted release];
    [studentIDField release];
    [super dealloc];
}
@end
