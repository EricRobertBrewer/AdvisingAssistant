//
//  SecondSideTableViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailViewController.h"
#import "CourseRepo.h"

@interface SecondSideTableViewController : UITableViewController {
    NSArray *areaArray;
    NSMutableArray *semesterArray, *areaCourses;
}

- (id)initWithAreas:(NSArray *)areas andSemesterArray:(NSMutableArray *)semesters;

@property (nonatomic, retain) ScheduleBuilderViewController *delagate;

@end
