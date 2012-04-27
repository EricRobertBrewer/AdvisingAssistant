//
//  SemesterTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterTableViewController.h"

@implementation SemesterTableViewController
@synthesize delagate;
@synthesize semester = _semester;
@synthesize semesterArray = _semesterArray;

-(void)dealloc {
    self.delagate = nil;
    self.semester = nil;
    self.semesterArray = nil;
    [super dealloc];
}

- (id)initWithSemester:(Semester *)semester andSemesterArray:(NSMutableArray *)semesters {
    self = [super init];
    if (self) {
        self.semester = semester;
        self.semesterArray = semesters;
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.semester.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil; //@"Cell";
    
    UITableViewCell *cell = nil; //[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[self.semester.courses objectAtIndex:indexPath.row] name];
    UILabel *units = [[UILabel alloc] initWithFrame:CGRectMake(3*cell.frame.size.width/8, cell.textLabel.frame.origin.y, cell.frame.size.width/8, cell.frame.size.height)];
    units.text = [NSString stringWithFormat:@"%i", [[self.semester.courses objectAtIndex:indexPath.row] units]];
    cell.accessoryView = units;
    
    return [cell autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Pull up daniel's view (course description) - send course and array of semesters
    CourseDetailViewController *courseDetail = [[[CourseDetailViewController alloc] initWithCourse:[self.semester.courses objectAtIndex:indexPath.row] andSemesters:self.semesterArray] autorelease];
    courseDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    courseDetail.delegate = self.delagate;
    [self presentModalViewController:courseDetail animated:YES];
}

@end
