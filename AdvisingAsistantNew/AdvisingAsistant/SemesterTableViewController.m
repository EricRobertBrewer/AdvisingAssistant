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
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    Course *course = [self.semester.courses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = course.nameOrCustomName;
    
    
    UILabel *units = [[UILabel alloc] initWithFrame:CGRectMake(3*cell.frame.size.width/8, cell.textLabel.frame.origin.y, cell.frame.size.width/8, cell.frame.size.height)];
    
    units.text = [NSString stringWithFormat:@"%i", course.units];
    
    cell.accessoryView = units;
    if (
        ([[course missingCoreqs:self.semesterArray by:self.semester.date] count] != 0)
        || 
        ([[course missingPrereqs:self.semesterArray by:self.semester.date] count] != 0)
        )
    {
        CGRect boxFrame = CGRectMake(2*cell.frame.size.width/5, 0, cell.frame.size.height, cell.frame.size.height);
        CourseWarningButtonView *warningButton = [[[CourseWarningButtonView alloc] initWithFrame:boxFrame] autorelease];
        warningButton.prereqs = [course missingPrereqs:self.semesterArray by:self.semester.date];
        warningButton.coreqs = [course missingCoreqs:self.semesterArray by:self.semester.date];
        [cell.contentView addSubview: warningButton];
    }
    
    [units release];
    
    return cell;
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
