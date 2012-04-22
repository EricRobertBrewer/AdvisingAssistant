//
//  SideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SideTableViewController.h"

@implementation SideTableViewController

- (id)initWithStyle:(UITableViewStyle)style andTitle:(NSString *)title
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = title;
        [self.tableView setFrame:CGRectMake(673, 44, 351, 1000)];
        GEArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"Ethnic Studies", @"Lab Requirement", nil];
        DepartmentSectionsArray = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"Ethnic Studies", @"Lab Requirement", nil];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.title == @"Required Courses") {
        if (section == 0)
            return @"General Education Courses";

        if (section == 1)
            return @"Deprtment Courses";
    }
    
    if (self.title == @"Second") {
        if (section == 0)
            return @"A";
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.title == @"Required Courses") {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.title == @"Required Courses") {
        if (section == 0)
            return 7;
    
        else if (section == 1)
            return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (self.title == @"Required Courses") {
        if (indexPath.section == 0) {
            cell.textLabel.text = [GEArray objectAtIndex:indexPath.row];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        if (indexPath.section == 1) {
            
        }
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SideTableViewController *temp = [[SideTableViewController alloc] initWithStyle:UITableViewStyleGrouped andTitle:@"Second"];
    
    [self.navigationController pushViewController:temp animated:YES];
}

@end
