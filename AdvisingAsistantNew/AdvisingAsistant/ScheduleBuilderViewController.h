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
#import "SideTableViewController.h"

@interface ScheduleBuilderViewController : UIViewController {
    
    IBOutlet UIScrollView *scrollView;

    NSArray *data;
    
    SideTableViewController *sideTable;
    
    int numberOfSemesters;
    
    NSMutableArray *semesterTables;
    
    IBOutlet UINavigationBar *sideNavBar;
    
    UINavigationController *sideNavBarController;
    
}

- (void)didTapLogout:(id)sender;
- (id)initWithStudent:(Student *)student andDepartment:(Department *)department;
- (id)initWithTemplate:(Template *)temp;

@end
