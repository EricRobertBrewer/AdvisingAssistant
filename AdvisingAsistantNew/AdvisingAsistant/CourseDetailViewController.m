//
//  CourseDetailViewController.m
//  AdvisingAssistant
//
//  Created by Daniel DePaolo on 4/6/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "ScheduleBuilderViewController.h"

@implementation CourseDetailViewController
@synthesize semesters;
@synthesize delegate;
@synthesize currentCourse = _currentCourse;
@synthesize addCourse = _addCourse;
@synthesize prereqs;
@synthesize coreqs;
@synthesize cwbv;
@synthesize semesterDate;

- (void)dealloc {
    [lblCourseName release];
    [lblUnits release];
    [txtCourseDesc release];
    [semesterStepper release];
    [semesterLabel release];
    [btnAddCourse release];
    [semesters release];
    [closeView release];
    [btnMoveCourse release];
    self.delegate = nil;
    self.currentCourse = nil;
    [btnRemoveCourse release];
    [customCourseName release];
    [lblCoreqs release];
    [lblPrereqs release];
    [super dealloc];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == customCourseName)
    {
        [textField resignFirstResponder];

        return YES;
    }
    return  YES;
}

- (BOOL) disablesAutomaticKeyboardDismissal {
    return NO;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    if (textField == customCourseName)
    {
        [UIView beginAnimations:nil context:nil];
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y+200);
        [UIView commitAnimations];
    }
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == customCourseName)
    {
        [UIView beginAnimations:nil context:nil];
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y-200);
        [UIView commitAnimations];
    }
}

-(id)initWithCourse:(Course *)course andSemesters:(NSMutableArray *)sems
{
    self = [super init];
    if (self) {
        self.currentCourse = course;
        self.semesters = sems;
        
        CourseRepo *cr = [CourseRepo defaultRepo];
        
        self.prereqs = [cr prereqsForCourse:self.currentCourse];
        self.coreqs = [cr coreqsForCourse:self.currentCourse];

        semesterIndexInArray = -1;
    }
    return self;
}

- (void)setSemesterDate:(SemesterDate)sd {
    semesterDate = sd;
    NSString *semDate = FormatSemesterDate(sd);
    
    for (Semester *s in self.semesters) {
        if ([semDate isEqualToString:[s getDateAsString]]) {
            [semesterStepper setValue:[semesterStepper value] + 1];
        }
    }
    
    [semesterLabel setText:semDate];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    assert(semesters);
    
    // set up prerequisites and corequisites
    NSMutableString *coreqString = [[NSMutableString alloc] init];
    
    for (Course *c in self.coreqs) {
        [coreqString appendFormat:@"%@   ", c.name];
    }
    [lblCoreqs setText:coreqString];
    
    NSMutableString *prereqString = [[NSMutableString alloc] init];
    
    for (Course *c in self.prereqs) {
        [prereqString appendFormat:@"%@   ", c.name];
    }
    [lblPrereqs setText:prereqString];
    
    // set initial semester setting
    if (self.addCourse) {
        Semester *initialSemester = [self.semesters objectAtIndex:0];
        [semesterLabel setText:[initialSemester getDateAsString]];
    }
    else {
        Semester *initialSemester = [self getSemesterWithDate:self.semesterDate];
        [semesterLabel setText:[initialSemester getDateAsString]];
    }
    
    // set course name title to course name passed in
    // OR to custom name
    
    NSString *courseHeading = [NSString stringWithFormat:@"%@: %@",
                               self.currentCourse.name, self.currentCourse.title];
    
    [lblCourseName setText:courseHeading];
    [lblUnits setText:[NSString stringWithFormat:@"%d",self.currentCourse.units]];
    [txtCourseDesc setText:self.currentCourse.description];
    
    // set up stepper
    [semesterStepper setMinimumValue:0];
    [semesterStepper setMaximumValue:(double)[semesters count]-1];
    
    if (self.addCourse) {
        btnMoveCourse.hidden = YES;
        btnRemoveCourse.hidden = YES;
        [semesterStepper setValue:0];
    } else {
        btnAddCourse.hidden = YES;
        [semesterStepper setValue:semesterIndexInArray];
    }
    
    self.cwbv = [[CourseWarningButtonView alloc] initWithFrame:CGRectMake(390, 460, 35, 35)];
    [self.view addSubview:self.cwbv];
    self.cwbv.hidden = ![self shouldShowWarning:self.semesterDate];
}

/*
- (void)viewDidUnload
{
    [lblCourseName release];
    lblCourseName = nil;
    [lblUnits release];
    lblUnits = nil;
    [lblGrade release];
    lblGrade = nil;
    [txtCourseDesc release];
    txtCourseDesc = nil;
    [semesterStepper release];
    semesterStepper = nil;
    [semesterLabel release];
    semesterLabel = nil;
    [btnAddCourse release];
    btnAddCourse = nil;
    [closeView release];
    closeView = nil;
    [btnMoveCourse release];
    btnMoveCourse = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// This is the function that will set into motion saving the course into the database
// and visually displaying it on the schedule
- (IBAction)addCourseClicked:(id)sender {

    for (Semester *sem in self.semesters) {
        
        if ([[sem getDateAsString] isEqualToString:semesterLabel.text]) {
            // User may have accidentally typed in 1 or 2 characters lol
            if (customCourseName.text.length > 2) {
                self.currentCourse.customName = customCourseName.text;
            }
                
            [sem.courses addObject:self.currentCourse];
            [self.delegate didTapSave:self.currentCourse]; 
            [self dismissModalViewControllerAnimated:NO];
        }
    }
}

- (BOOL)shouldShowWarning:(SemesterDate)sd {
    self.cwbv.prereqs = [self.currentCourse missingPrereqs:self.semesters by:sd];
    self.cwbv.coreqs = [self.currentCourse missingCoreqs:self.semesters by:sd];
    
    if ([self.cwbv.prereqs count] > 0 || [self.cwbv.coreqs count] > 0)
        return YES;
    else
        return NO;
}

- (Semester *)getSemesterWithDate:(SemesterDate)sd {
    
    semesterIndexInArray = -1;
    for (Semester *s in self.semesters) {
        semesterIndexInArray++;
        if (SemesterDateEqual(s.date, sd)) {
            return s;
        }
    }
    
    return nil;
}

// checks to see if a course is already in some semester
// if it is, RETURNS that semester
- (Semester *)getSemesterWithCourse {
    for (Semester *sem in self.semesters) {
        if ([self getCourseFromSemester:sem]) {
            return sem;
        }
    }
    
    return nil;
}

// just a little helper function
- (Course *)getCourseFromSemester:(Semester *)semester {
    for (Course *c in semester.courses) {
        if ([c.name isEqualToString:self.currentCourse.name]) {
            return c;
        }
    }
    
    return nil;
}

- (IBAction)StepperPressed:(id)sender {
    Semester *newSelectedSemester = [semesters objectAtIndex:(int)semesterStepper.value];
    [semesterLabel setText:[newSelectedSemester getDateAsString]];
    
    // Makes sure warning is updated when user selects diff semester
    if ([self shouldShowWarning:newSelectedSemester.date] == YES)
        self.cwbv.hidden = NO;
    else
        self.cwbv.hidden = YES;
}

- (IBAction)tappedCloseView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

// This is for users to move courses that are already in the schedule
- (IBAction)moveCourseClicked:(id)sender {
    
    Semester *semesterToMoveFrom = nil;

    NSLog(@"CourseToBeRemoved contains the course to be removed successfully!");

    for (Semester *sem in self.semesters) {
        if ([[sem getDateAsString] isEqualToString:semesterLabel.text]) {
            semesterToMoveFrom = [self getSemesterWithCourse];
            if (semesterToMoveFrom != nil) {
                [semesterToMoveFrom.courses removeObject:self.currentCourse];
                [sem.courses addObject:self.currentCourse];
                    
                [self.delegate didTapSave:self.currentCourse];
                
                // save custom name
                if (customCourseName.text.length > 2) {
                    self.currentCourse.customName = customCourseName.text;
                }
                [self dismissModalViewControllerAnimated:NO];
            }
        }
    }
    
    
}

- (IBAction)removeCourseClicked:(id)sender {
    
    Semester *semesterToRemoveFrom = nil;
    
    semesterToRemoveFrom = [self getSemesterWithDate:self.semesterDate];
    [semesterToRemoveFrom.courses removeObject:self.currentCourse];
    [self.delegate didTapSave:self.currentCourse];
    [self dismissModalViewControllerAnimated:NO];

}


- (void)viewDidUnload {
    [btnRemoveCourse release];
    btnRemoveCourse = nil;
    [customCourseName release];
    customCourseName = nil;
    [lblCoreqs release];
    lblCoreqs = nil;
    [lblPrereqs release];
    lblPrereqs = nil;
    [super viewDidUnload];
}
@end
