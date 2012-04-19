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
    
    if (!sideNavBarController) {
        
        sideTable = [[SideTableViewController alloc] initWithStyle:UITableViewStyleGrouped andTitle:@"First"];
        // Call initWithStudent or initWithTemplate
        
        [sideTable.tableView setFrame:CGRectMake(673, 44, 351, 1000)];
        
        sideNavBarController = [[UINavigationController alloc] initWithRootViewController:sideTable];
        
        [self.view addSubview:sideNavBarController.navigationBar];
        [self.view addSubview:sideTable.tableView];
        [sideNavBarController.navigationBar setFrame:CGRectMake(673, 0, 351, 44)];
        
    }
    
}

- (void)viewDidUnload
{
    [sideTable release];
    sideTable = nil;
    [scrollView release];
    scrollView = nil;
    [sideNavBar release];
    sideNavBar = nil;
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
        self.title = student.name;

        SemesterRepo *semArray = [[SemesterRepo alloc] init];
        numberOfSemesters = [[semArray semestersForStudent:student] count];
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            // Send it the semester and it can take out the array of courses and semester date
        }
        
        // Load courses into main table (sideTable) based on department
        
        
        
        [semArray release];
    }
    
    return self;
}

- (id)initWithTemplate:(Template *)temp {
    self = [super init];
    if (self) {
        // Make a semester repo (semesterForTemplate), returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.title = temp.name;
        
        SemesterRepo *semArray = [[SemesterRepo alloc] init];
        numberOfSemesters = [[semArray semestersForTemplate:temp] count];
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            // Send it the template and it can take out the array of courses and semester date
        }
        
        // Load courses into main table (sideTable) based on department (template.department)
        
        [semArray release];
    }
    
    return self;
}

- (void)dealloc {
    [sideTable release];
    [scrollView release];
    [sideNavBar release];
    [super dealloc];
}
@end
