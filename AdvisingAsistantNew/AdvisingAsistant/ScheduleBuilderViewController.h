//
//  ScheduleBuilderViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleBuilderViewController : UIViewController {
    
    IBOutlet UIScrollView *scrollView;

    IBOutlet UITableView *mainTable;
    NSArray *data;
    
    IBOutlet UITableView *semester1;
    IBOutlet UITableView *semester2;
    IBOutlet UITableView *semester3;
    IBOutlet UITableView *semester4;
    IBOutlet UITableView *semester5;
    IBOutlet UITableView *semester6;
    
}

- (void)initMainTableWithValues:(NSArray *)vals andTitle:(NSString *)title;

@end
