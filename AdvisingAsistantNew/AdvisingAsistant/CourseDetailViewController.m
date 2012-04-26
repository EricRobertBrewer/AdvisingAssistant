//
//  CourseDetailViewController.m
//  AdvisingAssistant
//
//  Created by Daniel DePaolo on 4/6/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "CourseDetailViewController.h"

@implementation CourseDetailViewController
@synthesize semesters;

-(id)initWithCourse:(Course *)course andSemesters:(NSMutableArray *)sems
{
    self = [super init];
    if (self) {
        currentCourse = course;
        
        // semesters is what is passed in only.
        // modifiedSemesters is the array after user adds course
        semesters = [[NSMutableArray alloc] init];
        for (Semester *sem in sems) {
            [semesters addObject:sem];
        }
        modifiedSemesters = sems;
        
        dbSemester = [SemesterRepo defaultRepo];
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
    [lblCourseName setText:currentCourse.name];
    [lblUnits setText:[NSString stringWithFormat:@"%d",currentCourse.units]];
    [txtCourseDesc setText:currentCourse.description];
    
    // set up stepper
    [semesterStepper setMinimumValue:0];
    [semesterStepper setMaximumValue:(double)[semesters count]-1];
    [semesterStepper setValue:0];
    
    
    // Do any additional setup after loading the view from its nib.
}

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

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
    [super dealloc];
}

// This is the function that will set into motion saving the course into the database
// and visually displaying it on the schedule
- (IBAction)addCourseClicked:(id)sender {
    for (Semester *sem in modifiedSemesters) {
        if ([[sem getDateAsString] isEqualToString:semesterLabel.text]) {
            if ([self isValidForSemester:sem])
                [sem.courses addObject:currentCourse];
        }
    }
    [self dismissModalViewControllerAnimated:NO];
}

// Checks to see if class is already in this semester
- (BOOL)isValidForSemester:(Semester *)selectedSem {
    for (Course *c in selectedSem.courses) {
        if ([c.name isEqualToString:currentCourse.name]) {
            return NO;
        }
    }
    
    return YES;
}

- (IBAction)StepperPressed:(id)sender {
    NSLog(@"Value of stepper: %d", (int)semesterStepper.value);
    Semester *newSelectedSemester = [semesters objectAtIndex:(int)semesterStepper.value];
    [semesterLabel setText:[newSelectedSemester getDateAsString]];
}

- (IBAction)tappedCloseView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    
// call some method on semester table view controller. probably want to store a pointer to it globally somewhere (singleton)    
}
 */

@end
