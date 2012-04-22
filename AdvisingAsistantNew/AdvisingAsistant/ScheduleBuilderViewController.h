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
#import "SemesterTableViewController.h"

@interface ScheduleBuilderViewController : UIViewController {
    
    UIScrollView *scrollView;
    
    UINavigationController *sideNavBarController;
    SideTableViewController *sideTable;
    
    int numberOfSemesters;
    NSMutableArray *semesterTables;
    
}

- (void)didTapLogout:(id)sender;
- (id)initWithStudent:(Student *)student andDepartment:(Department *)department;
- (id)initWithTemplate:(Template *)temp;

@end
