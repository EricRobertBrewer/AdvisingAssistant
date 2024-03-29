//
//  EmailExporter.h
//  AdvisingAsistant
//
//  Created by student on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Student.h"
#import "Semester.h"

@interface EmailExporter : NSObject <MFMailComposeViewControllerDelegate>

-(void)exportStudent:(Student *)student withSemesters:(NSArray *)semesters;

@end
