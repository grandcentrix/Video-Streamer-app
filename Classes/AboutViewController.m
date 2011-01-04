/*****************************************************************
 |
 | Copyright (c) 2011, Alexander Mobile, LLC.
 | All rights reserved.
 | http://www.alexandermobile.com
 |
 | This program is free software; you can redistribute it and/or
 | modify it under the terms of the GNU General Public License
 | version 2.0 as published by the Free Software Foundation. A
 | copy of the GNU General Public License is provided in the
 | LICENSE file.
 |
 ****************************************************************/

#import "AboutViewController.h"


@implementation AboutViewController


#pragma mark -
#pragma mark AboutViewController

- (void)dealloc
{
    [super dealloc];
}

- (IBAction)showLicense:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"License"
                                                    message:@"This app is released under the GPL version 2.0. The code can be found at github.com/baalexander/video-streamer-app"
                                                   delegate:self 
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


@end
