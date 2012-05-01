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
    
}

- (id)initWithAreas:(NSArray *)areas andSemesterArray:(NSMutableArray *)semesters;

@property (nonatomic, retain) NSArray *areaArray;
@property (nonatomic, retain) NSMutableArray *semesterArray;
@property (nonatomic, retain) NSMutableArray *areaCourses;
@property (nonatomic, retain) ScheduleBuilderViewController *delagate;

@end
