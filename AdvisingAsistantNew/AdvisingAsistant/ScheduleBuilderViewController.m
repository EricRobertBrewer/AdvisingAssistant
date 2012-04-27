//
//  ScheduleBuilderViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleBuilderViewController.h"

@implementation ScheduleBuilderViewController
@synthesize semesters = _semesters;
@synthesize semesterTables = _semesterTables;
@synthesize sideNavController = _sideNavController;

-(void)dealloc {
	self.semesters = nil;
	self.semesterTables = nil;
	self.sideNavController = nil;
	[super dealloc];
}

- (void)didTapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(void)initSideTableWithPattern:(GEPattern)pattern date:(SemesterDate)date department:(Department *)department semesters:(NSMutableArray *)semesters {
	SideTableViewController *sideTable = [[SideTableViewController alloc] initWithGEPattern:pattern date:date Department:department andSemesterArray:semesters];
	self.sideNavController = [[[UINavigationController alloc] initWithRootViewController:sideTable] autorelease];
	self.sideNavController.view.autoresizingMask = UIViewAutoresizingNone;
	[self.sideNavController.view setFrame:CGRectMake(673, 0, 351, 1000)];
	[self.view addSubview:self.sideNavController.view];
}

- (id)initWithStudent:(Student *)student andDepartment:(Department *)department {
    self = [super init];
    if (self) {
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        self.semesters = [NSMutableArray arrayWithArray:[semRepo semestersForStudent:student]];
		[self initSideTableWithPattern:student.pattern date:student.started department:department semesters:self.semesters];
		self.title = student.name;
    }
    return self;
}

- (id)initWithTemplate:(Template *)template {
    self = [super init];
    if (self) {
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        self.semesters = [NSMutableArray arrayWithArray:[semRepo semestersForTemplate:template]];
		[self initSideTableWithPattern:GEPatternFreshman date:SemesterDateNow() department:template.department semesters:self.semesters];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;    
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Logout"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self
                                  action:@selector(didTapLogout:)];
    self.navigationItem.rightBarButtonItem = logoutBtn;
	
	self.semesterTables = [NSMutableArray array];
	
	UIScrollView *scrollView = [[UIScrollView alloc] init];
	scrollView.frame = CGRectMake(0, 0, 673, 1000);
	scrollView.alwaysBounceVertical = YES;
	scrollView.scrollEnabled = YES;
	scrollView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:scrollView];
	
	// Make a semester repo with student, returns array of semesters
	// Each semester is an array of courses and has a date (term and year)
	
	int numberOfSemesters = [self.semesters count];
	
	scrollView.contentSize = CGSizeMake(673, (383*((numberOfSemesters/2)+(numberOfSemesters%2))*1.2));
	
	for (int i = 0; i < numberOfSemesters; i++) {
		// Create tables for scrollview
		Semester *tempSemester = [self.semesters objectAtIndex:i];
		SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:tempSemester andSemesterArray:self.semesters];
		
		// for Y switch spring side to match index of fall side (-1) then divide that by 2 (except 0) and multiply by offset (295)
		// EDIT talk to someone from group, fall always even?
		
		UILabel *semesterLabel = [[UILabel alloc] init];
		semesterLabel.text = FormatSemesterDate(tempSemester.date);
		
		int labelX;
		int tableX;
		if (tempSemester.date.season == SeasonFall) {
			labelX = 154;
			tableX = 62;
		} else {
			labelX = 442;
			tableX = 367;
		}

		int multiplier = (i/2);
		[semesterLabel setFrame:CGRectMake(labelX, ((295*multiplier)+88), 100, 21)];
		[tempSemesterTable.tableView setFrame:CGRectMake(tableX, ((295*multiplier)+123), 236, 230)];
		
		[scrollView addSubview:semesterLabel];
		[self.semesterTables addObject:tempSemesterTable];
		[scrollView addSubview:tempSemesterTable.tableView];
		
		[semesterLabel release];
	}
	
	[scrollView release];
}

@end
