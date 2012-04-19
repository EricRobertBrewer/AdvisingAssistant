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

-(id)initWithCourse:(NSString *)course
{
    self = [super init];
    if (self) {
        courseName = [[NSString alloc] initWithString:course];
        
        semesters = [[NSMutableArray alloc] init];
    }
    return self;
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
    
    // set course name title to course name passed in
    [lblCourseName setText:courseName];
    
    // Add the student's semesters here
    // (Won't be hardcoded later!)
    [semesters addObject:@"Fall 2009"];
    [semesters addObject:@"Spring 2010"];
    [semesters addObject:@"Fall 2010"];
    [semesters addObject:@"Spring 2011"];
    [semesters addObject:@"Fall 2011"];
    [semesters addObject:@"Spring 2012"];
    
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
    [courseName release];
    [super dealloc];
}
- (IBAction)addCourseClicked:(id)sender {
}

- (IBAction)StepperPressed:(id)sender {
    NSLog(@"Value of stepper: %d", (int)semesterStepper.value);
    [semesterLabel setText:[semesters objectAtIndex:(int)semesterStepper.value]];
}
@end
