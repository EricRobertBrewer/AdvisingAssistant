//
//  SideTableViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaRepo.h"
#import "Area.h"
#import "SecondSideTableViewController.h"
#import "GEPattern.h"
#import "SemesterDate.h"
#import "Department.h"

@interface SideTableViewController : UITableViewController {
	
}

@property (nonatomic, retain) NSMutableArray *semesterArray;
@property (nonatomic, retain) NSArray *GEArray;
@property (nonatomic, retain) NSArray *DepartmentSectionsArray;

- (id)initWithGEPattern:(GEPattern)pattern date:(SemesterDate)date Department:(Department *)dept andSemesterArray:(NSMutableArray *)semArray;

@end
