//
//  SecondSideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondSideTableViewController.h"

@implementation SecondSideTableViewController

- (id)initWithAreas:(NSArray *)areas andSemesterArray:(NSMutableArray *)semesters
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Takes array of areas, call function with each area for array of courses
        areaArray = [areas retain];
        semesterArray = [semesters retain];
        areaCourses =[NSMutableArray new];
        CourseRepo *repo = [CourseRepo defaultRepo];
        
        for (int i = 0; i < [areas count]; i++)
            [areaCourses addObject:(NSArray *)[repo coursesForArea:[areas objectAtIndex:i]]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [areaArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[areaCourses objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[areaCourses objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Pull up daniel's view (course description) - send course and array of semesters
    CourseDetailViewController *courseDetail = [[[CourseDetailViewController alloc] initWithCourse:[[[areaCourses objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:indexPath.row] andSemesters:semesterArray] autorelease];
    courseDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:courseDetail animated:YES];
}

@end
