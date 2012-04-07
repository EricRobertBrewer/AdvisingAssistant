//
//  DetailViewController.h
//  AdvisingAsistant
//
//  Created by student on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate> {
    
  
    IBOutlet UILabel *label2;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITableView *semester1;
    
    IBOutlet UITableView *semester2;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
