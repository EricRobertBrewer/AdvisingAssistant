//
//  NewStudentViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "NewStudentViewController.h"

@implementation NewStudentViewController
@synthesize season, year;

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
