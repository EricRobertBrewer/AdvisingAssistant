//
//  EmailExporter.m
//  AdvisingAsistant
//
//  Created by student on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailExporter.h"
#import "Course.h"
#import "AppDelegate.h"
#import "AANotify.h"

@implementation EmailExporter

-(void)exportStudent:(Student *)student withSemesters:(NSArray *)semesters {
    
    NSString *m = [NSString stringWithFormat:@"Student ID: %i\n",
                   "Student Name: %@\n", student.id, student.name];
    for (Semester *semester in semesters) {
        [m stringByAppendingFormat:@"\n-- %@ --\n", FormatSemesterDate(semester.date)];
        for (Course *course in semester.courses) {
            [m stringByAppendingFormat:@"%@ (%i units)\n", course.nameOrCustomName, course.units];
        }
    }
    
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    compose.mailComposeDelegate = self;
    [compose setSubject:[NSString stringWithFormat:@"%@ Schedule", student.name]];
    [compose setMessageBody:m isHTML:NO];
    if (compose) {
        [[[AppDelegate sharedInstance] topViewController] presentModalViewController:compose animated:YES];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [[[AppDelegate sharedInstance] topViewController] dismissModalViewControllerAnimated:YES];
    if (error) [AANotify present:CKNotifyAlertTypeError title:@"Error Sending Email" body:error.description duration:5];
}

@end