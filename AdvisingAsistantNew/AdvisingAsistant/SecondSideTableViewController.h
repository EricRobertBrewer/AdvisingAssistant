//
//  SecondSideTableViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailViewController.h"

@interface SecondSideTableViewController : UITableViewController {
    NSArray *areaArray;
    NSArray *semesterArray;
}

- (id)initWithAreas:(NSArray *)areas andSemesterArray:(NSArray *)semesters;

@end
