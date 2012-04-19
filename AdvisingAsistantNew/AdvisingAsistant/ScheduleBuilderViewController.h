//
//  ScheduleBuilderViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "Department.h"
#import "Template.h"
#import "SemesterRepo.h"
#import "AppDelegate.h"
#import "Semester.h"
#import "TableViewController.h"

@interface ScheduleBuilderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UIScrollView *scrollView;

    UITableViewController *mainTable;
    NSArray *data;
    
    int numberOfSemesters;
    
    NSMutableArray *semesterTables;
    
    IBOutlet UITableView *semester1;
    IBOutlet UITableView *semester2;
    IBOutlet UITableView *semester3;
    IBOutlet UITableView *semester4;
    IBOutlet UITableView *semester5;
    IBOutlet UITableView *semester6;
    IBOutlet UINavigationBar *sideNavBar;
    
    UINavigationController *sideNavBarController;
    
}

- (void)didTapLogout:(id)sender;
- (void)initMainTableWithValues:(NSArray *)vals andTitle:(NSString *)title;
- (id)initWithStudent:(Student *)student andDepartment:(Department *)department;
- (id)initWithTemplate:(Template *)temp;

@end
