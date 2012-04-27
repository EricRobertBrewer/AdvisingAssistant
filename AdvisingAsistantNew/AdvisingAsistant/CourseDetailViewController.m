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

- (void)dealloc {
    [lblCourseName release];
    [lblUnits release];
    [lblGrade release];
    [txtCourseDesc release];
    [semesterStepper release];
    [semesterLabel release];
    [btnAddCourse release];
    [semesters release];
    [closeView release];
    [btnMoveCourse release];
    self.delegate = nil;
    self.currentCourse = nil;
    [super dealloc];
}

-(id)initWithCourse:(Course *)course andSemesters:(NSMutableArray *)sems
{
    self = [super init];
    if (self) {
        self.currentCourse = course;
        self.semesters = sems;
    }
    return self;
}

-(void)showGrade:(NSString *)grade
{
    [lblGrade setText:grade];
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
    
    /*
    // set up the image
    if (currentCourse.department.code == @"CS")
        iconPic = [UIImage imageNamed:@"comppic.png"];
    else
        iconPic = [UIImage imageNamed:@"Sonoma_State_University.gif"];
    
    iconPicView = [[UIImageView alloc] initWithImage:iconPic];
    iconPicView.frame = CGRectMake(25, 25, iconPic.size.width*0.7, iconPic.size.height*0.7);
    [self.view addSubview:iconPicView];
     */
        
    
    // set initial semester setting
    Semester *initialSemester = [semesters objectAtIndex:0];
    [semesterLabel setText:[initialSemester getDateAsString]];
    
    // set course name title to course name passed in
    [lblCourseName setText:self.currentCourse.name];
    [lblUnits setText:[NSString stringWithFormat:@"%d",self.currentCourse.units]];
    [txtCourseDesc setText:self.currentCourse.description];
    
    // set up stepper
    [semesterStepper setMinimumValue:0];
    [semesterStepper setMaximumValue:(double)[semesters count]-1];
    [semesterStepper setValue:0];
    
    
    // Do any additional setup after loading the view from its nib.
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
            if (![self getSemesterWithCourse]) {
                [sem.courses addObject:self.currentCourse];
                [self.delegate didTapSave:self.currentCourse]; 
                [self dismissModalViewControllerAnimated:NO];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Course already added" 
                                                                  message:@"The course you selected is already in the schedule" 
                                                                 delegate:self 
                                                        cancelButtonTitle:@"OK" 
                                                        otherButtonTitles:nil];
                [alert show];
                [alert release];
                break;
            }
        }
    }
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
    NSLog(@"Value of stepper: %d", (int)semesterStepper.value);
    Semester *newSelectedSemester = [semesters objectAtIndex:(int)semesterStepper.value];
    [semesterLabel setText:[newSelectedSemester getDateAsString]];
}

- (IBAction)tappedCloseView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

// This is for users to move courses that are already in the schedule
- (IBAction)moveCourseClicked:(id)sender {
    
    Semester *semesterToMoveFrom = nil;
    Course *courseToBeRemoved = nil;
    
    // the semester to get course from... if it can't be found
    // ALREADY in schedule, no move can be done.
    if ((semesterToMoveFrom = [self getSemesterWithCourse])) {
        if ((courseToBeRemoved = [self getCourseFromSemester:semesterToMoveFrom])) {
            NSLog(@"CourseToBeRemoved contains the course to be removed successfully!");
            
            // Search for semester object that the user selected in the array of semesters
            // Do the move TO that semester FROM "semesterToMoveFrom"
            for (Semester *sem in self.semesters) {
                
                if ([[sem getDateAsString] isEqualToString:semesterLabel.text]) {
                    [semesterToMoveFrom.courses removeObject:courseToBeRemoved];
                    [sem.courses addObject:self.currentCourse];
                    
                    [self.delegate didTapSave:self.currentCourse];
                    [self dismissModalViewControllerAnimated:NO];
                }
            }
        }
        else {
            NSLog(@"Did not find the course to be REMOVED (or error)");
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Course can't be moved" 
                                                          message:@"The course you selected is not currently in the schedule and is not able to be moved." 
                                                         delegate:self 
                                                cancelButtonTitle:@"OK" 
                                                otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

@end
