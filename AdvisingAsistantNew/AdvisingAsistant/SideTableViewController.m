//
//  SideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SideTableViewController.h"

@implementation SideTableViewController

- (id)initWithGEPattern:(GEPattern)pattern date:(SemesterDate)date Department:(Department *)dept andSemesterArray:(NSMutableArray *)semArray
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"Required Courses";
        semesterArray = semArray;
        [self.tableView setFrame:CGRectMake(673, 44, 351, 1000)];
        tempRepo = [[AreaRepo alloc] init];
        GEArray = [[NSArray alloc] initWithArray:[tempRepo areasForGEPattern:pattern date:date]];
        DepartmentSectionsArray = [[NSArray alloc] initWithArray:[tempRepo areasForDepartment:dept date:date]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"General Education Courses";

    if (section == 1)
        return @"Deprtment Courses"; // Pull department name
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [GEArray count];
    
    else if (section == 1)
        return [DepartmentSectionsArray count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [GEArray objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [DepartmentSectionsArray objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SecondSideTableViewController *temp;
    if (indexPath.section == 0)
        temp = [[SecondSideTableViewController alloc] initWithAreas:[tempRepo areasForArea:[GEArray objectAtIndex:indexPath.row]] andSemesterArray:semesterArray];
    
    else if (indexPath.section == 1)
        temp = [[SecondSideTableViewController alloc] initWithAreas:[tempRepo areasForArea:[DepartmentSectionsArray objectAtIndex:indexPath.row]] andSemesterArray:semesterArray];
        
    [self.navigationController pushViewController:temp animated:YES];
}

@end
