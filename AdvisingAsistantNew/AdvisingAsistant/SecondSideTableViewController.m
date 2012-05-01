//
//  SecondSideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondSideTableViewController.h"

@implementation SecondSideTableViewController
@synthesize delagate;

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
    NSLog(@"Number of sections is %d", [areaCourses count]);
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [areaCourses count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[areaCourses objectAtIndex:section] count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Area *temp = [areaArray objectAtIndex:section];
    return [NSString stringWithFormat:@"%@ (%i units)", temp.title, temp.units];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Course *course = [[areaCourses objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", course.name, course.title];
    
     for (int i = 0; i < [semesterArray count]; i++) {
        NSArray *tempCourses = [[semesterArray objectAtIndex:i] courses];
        for (int j = 0; j < [tempCourses count]; j++) {
            if ([[tempCourses objectAtIndex:j] isEqualToCourse:course]) {
                cell.textLabel.textColor = [UIColor grayColor];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Pull up daniel's view (course description) - send course and array of semesters
    CourseDetailViewController *courseDetail = [[CourseDetailViewController alloc] initWithCourse:[[areaCourses objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] andSemesters:semesterArray];
    courseDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    courseDetail.delegate = self.delagate;
    courseDetail.addCourse = YES;
    [self presentModalViewController:courseDetail animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
