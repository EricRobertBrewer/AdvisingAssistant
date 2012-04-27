//
//  SideTableViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SideTableViewController.h"

@implementation SideTableViewController
@synthesize semesterArray = _semesterArray;
@synthesize GEArray = _GEArray;
@synthesize DepartmentSectionsArray = _DepartmentSectionsArray;

-(void)dealloc {
	self.semesterArray = nil;
	self.GEArray = nil;
	self.DepartmentSectionsArray = nil;
	[super dealloc];
}

- (id)initWithGEPattern:(GEPattern)pattern date:(SemesterDate)date Department:(Department *)dept andSemesterArray:(NSMutableArray *)semArray
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"Required Courses";
        self.semesterArray = semArray;
        self.GEArray = [[AreaRepo defaultRepo] areasForGEPattern:pattern date:date];
        self.DepartmentSectionsArray = [[AreaRepo defaultRepo] areasForDepartment:dept date:date];
    }
    return self;
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
        return [self.GEArray count];
    
    else if (section == 1)
        return [self.DepartmentSectionsArray count];
    return 0;
}

-(Area *)areaAtIndexPath:(NSIndexPath *)path {
	if (path.section == 0) {
		return [self.GEArray objectAtIndex:path.row];
	} else {
		return [self.DepartmentSectionsArray objectAtIndex:path.row];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Area *area = [self areaAtIndexPath:indexPath];
	cell.textLabel.text = area.title;
	cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	Area *area = [self areaAtIndexPath:indexPath];
	NSArray *areas = [[AreaRepo defaultRepo] areasForArea:area];
	
    SecondSideTableViewController *temp = [[SecondSideTableViewController alloc] initWithAreas:areas andSemesterArray:self.semesterArray];
    [self.navigationController pushViewController:temp animated:YES];
	[temp release];
}

@end
