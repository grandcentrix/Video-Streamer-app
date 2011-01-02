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

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "InstructionsViewController.h"
#import "FilesViewController.h"
#import "DirectoryWatcher.h"


@interface RootViewController : UIViewController <DirectoryWatcherDelegate>
{
    @private
        UIView *subview_;
        AboutViewController *aboutViewController_;
        InstructionsViewController *instructionsViewController_;
        FilesViewController *filesViewController_;
        DirectoryWatcher *directoryWatcher_;
        NSMutableArray *documentUrls_;
        BOOL showingAboutView_;
}

@property (nonatomic, retain) IBOutlet UIView *subview;
@property (nonatomic, retain) AboutViewController *aboutViewController;
@property (nonatomic, retain) InstructionsViewController *instructionsViewController;
@property (nonatomic, retain) FilesViewController *filesViewController;

-(IBAction)switchAbout:(id)sender;

@end
