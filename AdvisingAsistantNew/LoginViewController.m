//
//  LoginViewController.m
//  AdvisingAsistant
//
//  Created by Garrett Mulroney on 4/9/12.
//  Copyright (c) 2012 Sonoma State University. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usrnmTextField) {
        usrnm = usrnmTextField.text;
    }
    else if (textField == psswrdTextField) {
        psswrd = psswrdTextField.text;
    }
    if (textField == stndIDTextField) {
        [self didTapGo:(UITextField *)textField];
        return YES;
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    usrnmTextField.delegate = self;
    stndIDTextField.delegate = self;
    psswrdTextField.delegate = self; psswrdTextField.secureTextEntry = YES;
    repo = [[StudentRepo defaultRepo] retain];
}

- (void)viewDidUnload
{
    [usrnmTextField release];
    usrnmTextField = nil;
    [psswrdTextField release];
    psswrdTextField = nil;
    [stndIDTextField release];
    stndIDTextField = nil;
    [goBttn release];
    goBttn = nil;
    [editBttn release];
    editBttn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
    [usrnmTextField release];
    [psswrdTextField release];
    [stndIDTextField release];
    [goBttn release];
    [editBttn release];
    
    [super dealloc];
}
- (IBAction)didTapGo:(id)sender {
    [usrnmTextField resignFirstResponder];
    [psswrdTextField resignFirstResponder];
    [stndIDTextField resignFirstResponder];
    
    NSLog(@"User did tap go.\n");
    studentID = [stndIDTextField.text intValue];
    Student *temp = [repo studentWithId:studentID];
    if (temp == nil)
    {
        if (repo.error == nil)
        {
            [self.navigationController pushViewController:[[[NewStudentViewController alloc] initWithStudentID:studentID] autorelease]  animated:YES];
        }
        else
        {
            NSLog(@"%@", repo.error);
        }
    }
    
}

- (IBAction)didTapEdit:(id)sender {
}
@end
