//
//  SecondSideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondSideTableViewController.h"

@implementation SecondSideTableViewController
@synthesize areaArray = _areaArray;
@synthesize semesterArray = _semesterArray;
@synthesize areaCourses = _areaCourses;
@synthesize delagate = _delegate;

-(void)dealloc {
    self.areaArray = nil;
    self.semesterArray = nil;
    self.areaCourses = nil;
    self.delagate = nil;
    [super dealloc];
}

- (id)initWithAreas:(NSArray *)areas andSemesterArray:(NSMutableArray *)semesters
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Takes array of areas, call function with each area for array of courses
        self.areaArray = areas;
        self.semesterArray = semesters;
        self.areaCourses =[NSMutableArray array];
        CourseRepo *repo = [CourseRepo defaultRepo];
        
        for (int i = 0; i < [areas count]; i++)
            [self.areaCourses addObject:[repo coursesForArea:[areas objectAtIndex:i]]];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.areaCourses count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.areaCourses objectAtIndex:section] count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Area *temp = [self.areaArray objectAtIndex:section];
    return [NSString stringWithFormat:@"%@ (%i units)", temp.title, temp.units];
}

-(Course *)courseAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.areaCourses objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];

    cell.textLabel.textColor= [UIColor blackColor];
    
	Course *course = [self courseAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", course.name, course.title];
    
     for (int i = 0; i < [self.semesterArray count]; i++) {
        NSArray *tempCourses = [[self.semesterArray objectAtIndex:i] courses];
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
    // Pull up course description - send course and array of semesters
    Course *course = [self courseAtIndexPath:indexPath];
    CourseDetailViewController *courseDetail = [[CourseDetailViewController alloc] initWithCourse:course andSemesters:self.semesterArray];
    courseDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    courseDetail.delegate = self.delagate;
    courseDetail.addCourse = YES;
    [self presentModalViewController:courseDetail animated:YES];
    [courseDetail release];
}

@end
