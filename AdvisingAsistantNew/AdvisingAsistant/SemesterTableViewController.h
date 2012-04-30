//
//  SemesterTableViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Semester.h"
#import "SemesterDate.h"
#import "CourseDetailViewController.h"
#import "CourseWarningButtonView.h"

@interface SemesterTableViewController : UITableViewController {
    
}

@property (nonatomic, retain) ScheduleBuilderViewController *delagate;
@property (nonatomic, retain) Semester *semester;
@property (nonatomic, retain) NSMutableArray *semesterArray;

- (id)initWithSemester:(Semester *)semester andSemesterArray:(NSMutableArray *)semesters;


@end
