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
        
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        NSMutableArray *semArray = [[NSMutableArray alloc] initWithArray:[semRepo semestersForStudent:student]];
        
        if (!sideNavBarController) {
            
            sideTable = [[SideTableViewController alloc] initWithGEPattern:student.pattern date:SemesterDateNow() Department:department andSemesterArray:semArray];
            
            sideNavBarController = [[UINavigationController alloc] initWithRootViewController:sideTable];
            sideNavBarController.view.autoresizingMask = UIViewAutoresizingNone;
            
            [self.view addSubview:sideNavBarController.view];
            [sideNavBarController.view setFrame:CGRectMake(673, 0, 351, 1000)];
            //[self.view addSubview:sideTable.tableView];
            //[sideNavBarController.navigationBar setFrame:CGRectMake(673, 0, 351, 44)];
            
        }
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, 673, 1000);
        scrollView.alwaysBounceVertical = YES;
        scrollView.scrollEnabled = YES;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scrollView];
        
        // Make a semester repo with student, returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.title = student.name;

        numberOfSemesters = [semArray count];
        
        scrollView.contentSize = CGSizeMake(673, (383*((numberOfSemesters/2)+(numberOfSemesters%2))*1.2));
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            Semester *tempSemester = [semArray objectAtIndex:i];
            SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:tempSemester andSemesterArray:semArray];
            
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
                if (i == 0) {
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
        
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        NSMutableArray *semArray = [[NSMutableArray alloc] initWithArray:[semRepo semestersForTemplate:temp]];
        
        if (!sideNavBarController) {
            
            sideTable = [[SideTableViewController alloc] initWithGEPattern:GEPatternFreshman date:SemesterDateNow() Department:temp.department andSemesterArray:semArray];
            
            // Call initWithStudent or initWithTemplate
            
            sideNavBarController = [[UINavigationController alloc] initWithRootViewController:sideTable];
            sideNavBarController.view.autoresizingMask = UIViewAutoresizingNone;
            
            [self.view addSubview:sideNavBarController.view];
            [sideNavBarController.view setFrame:CGRectMake(673, 0, 351, 1000)];
            //[self.view addSubview:sideTable.tableView];
            //[sideNavBarController.navigationBar setFrame:CGRectMake(673, 0, 351, 44)];
            
        }
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, 673, 1000);
        scrollView.alwaysBounceVertical = YES;
        scrollView.scrollEnabled = YES;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scrollView];
        
        // Make a semester repo with student, returns array of semesters
        // Each semester is an array of courses and has a date (term and year)
        self.title = temp.name;
        
        numberOfSemesters = [semArray count];
        
        // Edit scrollview size based on number of semesters
        scrollView.contentSize = CGSizeMake(673, (383*((numberOfSemesters/2)+(numberOfSemesters%2))*1.2));
        
        for (int i = 0; i < numberOfSemesters; i++) {
            // Create tables for scrollview
            Semester *tempSemester = [semArray objectAtIndex:i];
            SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:tempSemester andSemesterArray:semArray];
            
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

- (void)dealloc {
    [sideTable release];
    [scrollView release];
    [super dealloc];
}
@end
