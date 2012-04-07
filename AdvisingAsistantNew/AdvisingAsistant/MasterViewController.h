//
//  MasterViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    NSArray *data;
}

- (id)initWithValues:(NSArray *)vals andTitle:(NSString *)title;

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
