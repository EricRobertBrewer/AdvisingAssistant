//
//  ScheduleBuilderViewController.m
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleBuilderViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "SecondSideTableViewController.h"

#define BAR_HEIGHT 66

@implementation ScheduleBuilderViewController
@synthesize semesters = _semesters;
@synthesize semesterTables = _semesterTables;
@synthesize sideNavController = _sideNavController;
@synthesize currentTemplate = _currentTemplate;
@synthesize currentStudent = _currentStudent;
@synthesize emailExporter = _emailExporter;

-(void)dealloc {
	self.semesters = nil;
	self.semesterTables = nil;
	self.sideNavController = nil;
    self.currentStudent = nil;
    self.currentTemplate = nil;
    self.emailExporter = nil;
	[super dealloc];
}

- (void)didTapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(void)setupSideTableWithPattern:(GEPattern)pattern date:(SemesterDate)date department:(Department *)department semesters:(NSMutableArray *)semesters {
    NSLog(@"%@", department.code);
	SideTableViewController *sideTable = [[SideTableViewController alloc] initWithGEPattern:pattern date:date Department:department andSemesterArray:semesters];
    sideTable.delagate = self;
	self.sideNavController = [[[UINavigationController alloc] initWithRootViewController:sideTable] autorelease];
	self.sideNavController.view.autoresizingMask = UIViewAutoresizingNone;
	[self.sideNavController.view setFrame:CGRectMake(673, BAR_HEIGHT, 351, 1000)];
	[self.view addSubview:self.sideNavController.view];
    [sideTable release];
}

- (id)initWithStudent:(Student *)student andDepartment:(Department *)department {
    self = [super init];
    if (self) {
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        self.semesters = [NSMutableArray arrayWithArray:[semRepo semestersForStudent:student]];
		self.title = student.name;
        self.currentStudent = student;
		[self setupSideTableWithPattern:student.pattern date:student.started department:department semesters:self.semesters];
    }
    return self;
}

- (id)initWithTemplate:(Template *)template {
    self = [super init];
    if (self) {
        SemesterRepo *semRepo = [SemesterRepo defaultRepo];
        self.semesters = [NSMutableArray arrayWithArray:[semRepo semestersForTemplate:template]];
        self.title = template.name;
        self.currentTemplate = template;
		[self setupSideTableWithPattern:GEPatternFreshman date:SemesterDateNow() department:template.department semesters:self.semesters];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, BAR_HEIGHT)];
	topBar.backgroundColor = [UIColor colorWithRed:0 green:81/255.0 blue:164/255.0 alpha:1];
	/*
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = topBar.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:120/255.0 blue:200/255.0 alpha:1] CGColor], (id)[[UIColor colorWithRed:0 green:60/255.0 blue:140/255.0 alpha:1] CGColor], nil];
    [topBar.layer insertSublayer:gradient atIndex:0];
	*/
    [self.view addSubview:topBar];
    [topBar release];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutBtn addTarget:self action:@selector(didTapLogout:) forControlEvents:UIControlEventTouchDown];
    logoutBtn.frame = CGRectMake(900, 15, 107, 38);
    [logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];
    
    UIButton *exportBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    exportBtn.frame = CGRectMake(780, 15, 100, 38);
    [exportBtn setTitle:@"Export" forState:UIControlStateNormal];
    [exportBtn addTarget:self action:@selector(didTapExport) forControlEvents:UIControlEventTouchDown];
    if (self.currentStudent) {
        [self.view addSubview:exportBtn];
    }
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(62, 11, 400, 40)];
    titleLbl.text = self.title;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:titleLbl];
	titleLbl.shadowOffset = CGSizeMake(1, 1);
	titleLbl.shadowColor = [UIColor blackColor];
	[titleLbl release];
	
	self.semesterTables = [NSMutableArray array];
	
	UIScrollView *scrollView = [[UIScrollView alloc] init];
	scrollView.frame = CGRectMake(0, BAR_HEIGHT, 673, 1000);
	scrollView.alwaysBounceVertical = YES;
	scrollView.scrollEnabled = YES;
	scrollView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:scrollView];
	
	int numberOfSemesters = [self.semesters count];
	
	scrollView.contentSize = CGSizeMake(673, 15+295+((numberOfSemesters/2)*295));
	
	for (int i = 0; i < numberOfSemesters; i++) {
		// Create semester tables for scrollview
		Semester *tempSemester = [self.semesters objectAtIndex:i];
		SemesterTableViewController *tempSemesterTable = [[SemesterTableViewController alloc] initWithSemester:tempSemester andSemesterArray:self.semesters];
		tempSemesterTable.delagate = self;
		
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
		[semesterLabel setFrame:CGRectMake(labelX, ((295*multiplier)+15), 100, 21)];
		[tempSemesterTable.tableView setFrame:CGRectMake(tableX, ((295*multiplier)+50), 236, 230)];
		
		[scrollView addSubview:semesterLabel];
		[self.semesterTables addObject:tempSemesterTable];
		[scrollView addSubview:tempSemesterTable.tableView];
		
		[semesterLabel release];
        [tempSemesterTable release];
	}
	
	[scrollView release];
}

-(void)didTapExport {
    if (!self.emailExporter) {
        self.emailExporter = [[[EmailExporter alloc] init] autorelease];
    }
    [self.emailExporter exportStudent:self.currentStudent withSemesters:self.semesters];
}
 
- (void) didTapSave:(Course *)course {
    SemesterRepo *repo = [SemesterRepo defaultRepo];
    if (self.currentStudent != nil)
        [repo saveSemesters:self.semesters forStudent:self.currentStudent];
    else
        [repo saveSemesters:self.semesters forTemplate:self.currentTemplate];
    
    for (int i = 0; i < [self.semesterTables count]; i++)
    {
        SemesterTableViewController *temp = [self.semesterTables objectAtIndex:i];
        [temp.tableView reloadData];
    }
    
    UIViewController *sideNav = self.sideNavController.topViewController;
    if ([sideNav isKindOfClass:[SecondSideTableViewController class]]) {
        SecondSideTableViewController *svc = (SecondSideTableViewController *)sideNav;
        [svc.tableView reloadData];
    }
}

- (void) didTapDelete:(Course *)course {
    [self didTapSave:course];
    
}

@end
