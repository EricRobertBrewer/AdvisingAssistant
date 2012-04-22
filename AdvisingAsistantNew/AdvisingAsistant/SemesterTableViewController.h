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

@interface SemesterTableViewController : UITableViewController {
    NSArray *courses;
    NSArray *semesterArray;
}

- (id)initWithSemester:(Semester *)semester andSemesterArray:(NSArray *)semesters;


@end
