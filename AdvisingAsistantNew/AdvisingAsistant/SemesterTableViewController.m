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

- (id)initWithSemester:(Semester *)semester andSemesterArray:(NSMutableArray *)semesters {
    self = [super init];
    if (self) {
        courses = [semester.courses retain];
        semesterArray = [semesters retain];
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
    return [courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[courses objectAtIndex:indexPath.row] name];
    UILabel *units = [[UILabel alloc] initWithFrame:CGRectMake(3*cell.frame.size.width/8, cell.textLabel.frame.origin.y, cell.frame.size.width/8, cell.frame.size.height)];
    units.text = [NSString stringWithFormat:@"%i", [[courses objectAtIndex:indexPath.row] units]];
    cell.accessoryView = units;
    
    return [cell autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Pull up daniel's view (course description) - send course and array of semesters
    CourseDetailViewController *courseDetail = [[[CourseDetailViewController alloc] initWithCourse:[courses objectAtIndex:indexPath.row] andSemesters:semesterArray] autorelease];
    courseDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:courseDetail animated:YES];
}

@end
