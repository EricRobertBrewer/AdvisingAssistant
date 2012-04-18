//
//  CourseDetailViewController.m
//  AdvisingAssistant
//
//  Created by Daniel DePaolo on 4/6/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "CourseDetailViewController.h"

@implementation CourseDetailViewController

-(id)initWithCourse:(NSString *)course
{
    self = [super init];
    if (self) {
        courseName = course;
        lblCourseName.text = courseName;
        
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
    
    [semesters addObject:@"Fall 2009"];
    [semesters addObject:@"Spring 2010"];
    [semesters addObject:@"Fall 2010"];
    [semesters addObject:@"Spring 2011"];
    [semesters addObject:@"Fall 2011"];
    [semesters addObject:@"Spring 2012"];
    
    semesterStepper.minimumValue = 0;
    semesterStepper.maximumValue = (double)(semesters.count - 1);
    semesterStepper.value = 1;
    
    
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
    [super dealloc];
}
- (IBAction)addCourseClicked:(id)sender {
}

- (IBAction)StepperPressed:(id)sender {
    int stepperValue = (int)semesterStepper.value;
    semesterLabel.text = [semesters objectAtIndex:stepperValue];;
}
@end
