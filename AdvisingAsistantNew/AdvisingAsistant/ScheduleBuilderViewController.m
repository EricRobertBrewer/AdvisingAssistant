//
//  ScheduleBuilderViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleBuilderViewController.h"

@implementation ScheduleBuilderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Main Table
        NSArray *temp = [[NSArray alloc] initWithObjects:@"A", @"B", nil];
        [self initMainTableWithValues:temp andTitle:@"Graduation Requirements"];
        [temp release];
    }
    return self;
};

- (void)didTapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height*1.2);
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Logout"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self
                                  action:@selector(didTapLogout:)];
    self.navigationItem.rightBarButtonItem = logoutBtn;
}

- (void)viewDidUnload
{
    [mainTable release];
    mainTable = nil;
    [semester1 release];
    semester1 = nil;
    [semester2 release];
    semester2 = nil;
    [semester3 release];
    semester3 = nil;
    [semester4 release];
    semester4 = nil;
    [scrollView release];
    scrollView = nil;
    [semester5 release];
    semester5 = nil;
    [semester6 release];
    semester6 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (id)initWithStudent:(Student *)student andDepartment:(Department *)department {
    self = [super init];
    if (self) {
        // Make a semester repo with student, returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.navigationController.title = student.name;
    }
    return self;
}

- (id)initWithTemplate:(Template *)temp {
    self = [super init];
    if (self) {
        // Make a semester repo (semesterForTemplate), returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
    }
    return self;
}

// ----- Table Controller -----

- (void)initMainTableWithValues:(NSArray *)vals andTitle:(NSString *)title;
{
    data = [[NSArray alloc] initWithArray:vals];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
        return [data count];
    else
        return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    int idx = indexPath.row;
    
    if (tableView.tag == 0)
        cell.textLabel.text = [data objectAtIndex:idx];
    
    return cell;
}

- (void)dealloc {
    [mainTable release];
    [semester1 release];
    [semester2 release];
    [semester3 release];
    [semester4 release];
    [scrollView release];
    [semester5 release];
    [semester6 release];
    [super dealloc];
}
@end
