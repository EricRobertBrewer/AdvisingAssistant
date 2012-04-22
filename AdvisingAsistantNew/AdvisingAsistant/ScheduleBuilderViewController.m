//
//  ScheduleBuilderViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleBuilderViewController.h"

@implementation ScheduleBuilderViewController

- (void)didTapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Logout"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self
                                  action:@selector(didTapLogout:)];
    self.navigationItem.rightBarButtonItem = logoutBtn;
    
    if (!sideNavBarController) {
        
        sideTable = [[SideTableViewController alloc] initWithStyle:UITableViewStyleGrouped andTitle:@"Required Courses"];
        // Call initWithStudent or initWithTemplate
        
        sideNavBarController = [[UINavigationController alloc] initWithRootViewController:sideTable];
        
        [self.view addSubview:sideNavBarController.view];
        [sideNavBarController.view setFrame:CGRectMake(673, 0, 351, 1000)];
        //[self.view addSubview:sideTable.tableView];
        //[sideNavBarController.navigationBar setFrame:CGRectMake(673, 0, 351, 44)];
        
    }
}

- (void)viewDidUnload
{
    [sideTable release];
    sideTable = nil;
    [scrollView release];
    scrollView = nil;
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
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, 673, 1000);
        scrollView.alwaysBounceVertical = YES;
        scrollView.scrollEnabled = YES;
        [self.view addSubview:scrollView];
        
        // Make a semester repo with student, returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.title = student.name;
        
        /*if (!sideNavBarController) {
            sideTable = [[SideTableViewController alloc] initWithStyle:UITableViewStyleGrouped andTitle:@"Required Courses"];
            // Call initWithStudent or initWithTemplate
         
            sideNavBarController = [[UINavigationController alloc] initWithRootViewController:sideTable];
         
            [self.view addSubview:sideNavBarController.view];
            [sideNavBarController.view setFrame:CGRectMake(673, 0, 351, 1000)];
            //[self.view addSubview:sideTable.tableView];
            //[sideNavBarController.navigationBar setFrame:CGRectMake(673, 0, 351, 44)];
        }*/

        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        NSArray *semArray = [semRepo semestersForStudent:student];
        numberOfSemesters = [semArray count];
        
        // Edit scrollview size based on number of semesters
        scrollView.contentSize = CGSizeMake(673, (383*((numberOfSemesters/2)+(numberOfSemesters%2))*1.2));
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            Semester *tempSemester = [semArray objectAtIndex:i];
            NSArray *tempCourses = [tempSemester courses];
            SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:[semArray objectAtIndex:i]];
            
            // for Y switch spring side to match index of fall side (-1) then divide that by 2 (except 0) and multiply by offset (295)
            // EDIT talk to someone from group, fall always even?
            
            UILabel *semesterLabel = [[UILabel alloc] init];
            int multiplier = 0;
            if (tempSemester.date.season == SeasonFall) {
                semesterLabel.text = [NSString stringWithFormat:@"Fall %i", tempSemester.date.year];
                if (i == 0) {
                    // special case - no need to multiply
                    semesterLabel.frame = CGRectMake(154, 88, 100, 21);
                }
                else {
                    // multpily value of label+table by multiplier (295) and add to starting Y value (88)
                    multiplier = i/2;
                    semesterLabel.frame = CGRectMake(154, ((295*multiplier)+88), 100, 21);
                }
                
                [tempSemesterTable.tableView setFrame:CGRectMake(62, ((295*multiplier)+123), 236, 230)];
            }
            
            if (tempSemester.date.season == SeasonSpring) {
                semesterLabel.text = [NSString stringWithFormat:@"Spring %i", tempSemester.date.year];
                if (i == 1) {
                   // special case - no need to multiply
                    semesterLabel.frame = CGRectMake(442, 88, 100, 21);             
                }
                else {
                    // multpily value of label+table by multiplier (295) and add to starting Y value (88)
                    multiplier = (i-1)/2;
                    semesterLabel.frame = CGRectMake(442, ((295*multiplier)+88), 100, 21);
                }
                
                [tempSemesterTable.tableView setFrame:CGRectMake(367, ((295*multiplier)+123), 236, 230)];
            }
            
            [scrollView addSubview:semesterLabel];
            [semesterTables addObject:tempSemesterTable];
            [scrollView addSubview:tempSemesterTable.tableView];
            
            [semesterLabel release];
        }
    }
    
    return self;
}

- (id)initWithTemplate:(Template *)temp {
    self = [super init];
    if (self) {
        // Make a semester repo (semesterForTemplate), returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.title = temp.name;
        
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        NSArray *semArray = [semRepo semestersForTemplate:temp];
        numberOfSemesters = [semArray count];
        
        // Edit scrollview size based on number of semesters
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, (383*((numberOfSemesters/2)+(numberOfSemesters%2))*1.2));
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            Semester *tempSemester = [semArray objectAtIndex:i];
            SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:[semArray objectAtIndex:i]];
            
            // for Y switch spring side to match index of fall side (-1) then divide that by 2 (except 0) and multiply by offset (295)
            // EDIT talk to someone from group, fall always even?
            
            UILabel *semesterLabel = [[UILabel alloc] init];
            int multiplier = 0;
            if (tempSemester.date.season == SeasonFall) {
                semesterLabel.text = [NSString stringWithFormat:@"Fall %i", tempSemester.date.year];
                if (i == 0) {
                    // special case - no need to multiply
                    semesterLabel.frame = CGRectMake(154, 88, 52, 21);
                }
                else {
                    // multpily value of label+table by multiplier (295) and add to starting Y value (88)
                    multiplier = i/2;
                    semesterLabel.frame = CGRectMake(154, ((295*multiplier)+88), 52, 21);
                }
                
                [tempSemesterTable.tableView setFrame:CGRectMake(62, ((295*multiplier)+123), 236, 230)];
            }
            
            if (tempSemester.date.season == SeasonSpring) {
                semesterLabel.text = [NSString stringWithFormat:@"Spring %i", tempSemester.date.year];
                if (i == 1) {
                    // special case - no need to multiply
                    semesterLabel.frame = CGRectMake(442, 88, 52, 21);
                }
                else {
                    // multpily value of label+table by multiplier (295) and add to starting Y value (88)
                    multiplier = (i-1)/2;
                    semesterLabel.frame = CGRectMake(442, ((295*multiplier)+88), 52, 21);
                }
                
                [tempSemesterTable.tableView setFrame:CGRectMake(367, ((295*multiplier)+123), 236, 230)];
            }
            
            [self.view addSubview:semesterLabel];
            [semesterTables addObject:tempSemesterTable];
            [self.view addSubview:tempSemesterTable.tableView];
            
            [semesterLabel release];
            [tempSemesterTable release];
        }
    }
    
    return self;
}

- (void)dealloc {
    [sideTable release];
    [scrollView release];
    [super dealloc];
}
@end
