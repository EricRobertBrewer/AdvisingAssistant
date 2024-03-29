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
#import "Semester.h"

@implementation NewStudentViewController
@synthesize season, year, parentController, T, templates, transferTemplates, freshmenTemplates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithStudentID:(int)ID andDepartment:(Department *)department {
    self = [super init];
    if (self) {
        studentID = ID;
        D = [department retain];
    }
    return self;
}

- (IBAction)didTapSubmit:(id)sender {
    if ([studentName.text length] > 0 && [studentIDField.text length] > 0 && [semesterStarted.text length] > 0 && [GEPatternField.text length] > 0)
    {
        submit = YES;
        Student * stud = [[[Student alloc] init] autorelease];
        stud.name = studentName.text;
        stud.id = [studentIDField.text intValue];
        Season t = (self.season == @"Fall") ? SeasonFall: SeasonSpring;
        stud.started = SemesterDateMake(t, [self.year intValue]);
        if ([GEPatternField.text isEqualToString:@"Freshman Pattern"])
            stud.pattern = GEPatternFreshman;
        else if ([GEPatternField.text isEqualToString:@"Transfer Pattern"])
            stud.pattern = GEPatternTransfer;
        
        StudentRepo *repo = [StudentRepo defaultRepo];
        [repo saveStudent:stud];
        
        if ([templateField.text length] > 0)
        {
			// TODO: This won't work if student starts in the spring
            SemesterRepo *sRepo = [SemesterRepo defaultRepo];
            NSArray *schedule = [sRepo semestersForTemplate:T];
            for (int i = 0; i < [schedule count]; i++)
            {
                Semester *s = [schedule objectAtIndex:i];
                s.date = SemesterDateMake(s.date.season, s.date.year+stud.started.year);
            }
            [sRepo saveSemesters:schedule forStudent:stud];
        }
        if (repo.error != nil)
        {
            NSLog(@"%@", repo.error);
            return;
        }
        
        DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
        ScheduleBuilderViewController *temp = [[[ScheduleBuilderViewController alloc] initWithStudent:stud andDepartment:[dRepo departmentWithCode:@"CS"]] autorelease];
        parentController.nextController = temp;
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)didTapExit:(id)sender {
    submit = NO;
    [self dismissModalViewControllerAnimated:YES];
}

-(void) viewDidDisappear:(BOOL)animated {
    if (submit)
    {
        parentController.studentIDTextField.text = @"";
        [parentController.navigationController pushViewController:parentController.nextController animated:YES];
    }
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == pickerView1)
        return 2;
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
        if (component == 0)
            return 2;
        return 50;
    }
    else if (pickerView == pickerView2)
    {
        if ([GEPatternField.text isEqualToString:@"Freshmen Pattern"])
            return [self.freshmenTemplates count]+1;
        else if ([GEPatternField.text isEqualToString:@"Transfer Pattern"])
            return [self.transferTemplates count]+1;
    }
    else if (pickerView == pickerView3)
        return 2;
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == pickerView1)
    {
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
    else if (pickerView == pickerView2)
    {
        if (row == 0)
            return @"";
        Template *temp = nil;
        if ([GEPatternField.text isEqualToString:@"Freshmen Pattern"])
            temp = [self.freshmenTemplates objectAtIndex:row-1];
        else if ([GEPatternField.text isEqualToString:@"Transfer Pattern"])
            temp = [self.transferTemplates objectAtIndex:row-1];
        return temp.name;
    }
    else if (pickerView == pickerView3)
    {
        if (row == 0)
            return @"Freshmen Pattern";
        return @"Transfer Pattern";
    }
    return  @"WRONG PICKERVIEW";
}

- (float)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (pickerView == pickerView1)
        return self.view.frame.size.width/2;
    return self.view.frame.size.width;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == pickerView1) 
    {
        if (component == 1)
            self.year = [self pickerView:pickerView titleForRow:row forComponent:component];
        else
            self.season = [self pickerView:pickerView titleForRow:row forComponent:component];
        semesterStarted.text = [NSString stringWithFormat:@"%@ %@", self.season, self.year];
    }
    else if (pickerView == pickerView2)
    {
        if (row > 0)
        {
            if ([GEPatternField.text isEqualToString:@"Freshmen Pattern"])
                self.T = [freshmenTemplates objectAtIndex:(row-1)];
            else if ([GEPatternField.text isEqualToString:@"Transfer Pattern"])
            {
                self.T = [transferTemplates objectAtIndex:row-1];
            }
        }
        templateField.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    else if (pickerView == pickerView3)
    {
        GEPatternField.text = [self pickerView:pickerView3 titleForRow:row forComponent:component];
        [pickerView2 selectRow:0 inComponent:0 animated:NO];
        templateField.text = [self pickerView:pickerView2 titleForRow:0 forComponent:0];
        [pickerView2 reloadAllComponents];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    TemplateRepo *repo = [TemplateRepo defaultRepo];
    DepartmentRepo *dRepo = [DepartmentRepo defaultRepo];
    submit = NO;
    
    studentIDField.text = [NSString stringWithFormat:@"%d", studentID];
    
    pickerView1 = [[UIPickerView alloc] init];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.showsSelectionIndicator = YES;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSYearCalendarUnit fromDate:[NSDate date]];
    int yearRow = [components year] - 2000;
    int seasonRow = 0;
    [pickerView1 selectRow:yearRow inComponent:1 animated:YES];
    self.year = [self pickerView:pickerView1 titleForRow:yearRow forComponent:1];
    self.season = [self pickerView:pickerView1 titleForRow:seasonRow forComponent:0];
    semesterStarted.inputView = pickerView1;
    semesterStarted.text = [NSString stringWithFormat:@"%@ %@", season, year];
    semesterStarted.inputView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    self.templates = [repo templatesForDepartment:[dRepo departmentWithCode:D.code]];
    self.freshmenTemplates = [NSMutableArray array];
    self.transferTemplates = [NSMutableArray array];
    for (int i = 0; i < [self.templates count]; i++)
    {
        Template *t = [self.templates objectAtIndex:i];
        if (t.pattern == GEPatternFreshman)
            [self.freshmenTemplates addObject:t];
        else if (t.pattern == GEPatternTransfer)
            [self.transferTemplates addObject:t];
    }
    
    self.templates = nil;
    
    pickerView2 = [[UIPickerView alloc] init];
    pickerView2.delegate = self;
    pickerView2.dataSource = self;
    pickerView2.showsSelectionIndicator = YES;
    [pickerView2 selectRow:0 inComponent:0 animated:YES];
    templateField.inputView = pickerView2;
    templateField.inputView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    pickerView3 = [[UIPickerView alloc] init];
    pickerView3.delegate = self;
    pickerView3.dataSource = self;
    pickerView3.showsSelectionIndicator = YES;
    [pickerView3 selectRow:0 inComponent:0 animated:YES];
    GEPatternField.inputView = pickerView3;
    GEPatternField.text = [self pickerView:pickerView3 titleForRow:0 forComponent:0];
    GEPatternField.inputView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    
    
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
        [GEPatternField becomeFirstResponder];
        return YES;
    }
    if (textField == GEPatternField)
    {
        [templateField becomeFirstResponder];
        return YES;
    }
    if (textField == templateField) {
        [self didTapSubmit:(UITextField *)textField];
        return  YES;
    }
    return NO;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)dealloc {
    self.freshmenTemplates = nil;
    self.transferTemplates = nil;
    self.T = nil;
    self.year = nil;
    self.season = nil;
    [pickerView1 release];
    [pickerView2 release];
    [pickerView3 release];
    [parentController release];
    [studentName release];
    [semesterStarted release];
    [studentIDField release];
    [templateField release];
    [GEPatternField release];
    [super dealloc];
}
@end
