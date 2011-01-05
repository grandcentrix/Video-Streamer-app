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

#import "RootViewController.h"
#import "UpnpServer.h"
#import "DeviceUtilities.h"


@interface RootViewController ()
@property (nonatomic, retain) DirectoryWatcher *directoryWatcher;
@property (nonatomic, retain) NSMutableArray *documentUrls;
@property (nonatomic, assign) BOOL showingAboutView;
@end


@implementation RootViewController

@synthesize subview = subview_;
@synthesize aboutViewController = aboutViewController_;
@synthesize instructionsViewController = instructionsViewController_;
@synthesize filesViewController = filesViewController_;
@synthesize directoryWatcher = directoryWatcher_;
@synthesize documentUrls = documentUrls_;
@synthesize showingAboutView = showingAboutView_;


#pragma mark -
#pragma mark RootViewController

- (void)dealloc
{
    [subview_ release];
    [aboutViewController_ release];
    [instructionsViewController_ release];
    [filesViewController_ release];
    [directoryWatcher_ release];
    [documentUrls_ release];
    
    [super dealloc];
}

-(IBAction)switchAbout:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.subview cache:NO];
    
    // Remove whatever view is currently showing
    for (UIView *view in self.subview.subviews)
    {
        [view removeFromSuperview];
    }    
    
    // If coming from the About view, determine which view to show based on if 
    // files in directory
    if (self.showingAboutView)
    {
        self.showingAboutView = NO;
        
        [self directoryDidChange:self.directoryWatcher];
    }
    // If the About view was not being shown, switch to that
    else
    {
        self.showingAboutView = YES;
        
        if (self.aboutViewController == nil)
        {
            NSString *nibName = [DeviceUtilities qualifiedNibNameForRootName:@"AboutView"];
            AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:nibName bundle:nil];
            self.aboutViewController = aboutViewController;
            [aboutViewController release];
        }
        
        self.aboutViewController.view.frame = CGRectMake(0, 0, self.subview.frame.size.width, self.subview.frame.size.height);
        [self.subview addSubview:self.aboutViewController.view];
    }
    
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark DirectoryWatcherDelegate

- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
{
    // Remove subview as view may change based on directory content
    for (UIView *view in self.subview.subviews)
    {
        [view removeFromSuperview];
    }

	[self.documentUrls removeAllObjects];    
    NSArray *files = [UpnpServer documentsDirectoryContents];
    if (files == nil || [files count] == 0)
    {
        if (self.instructionsViewController == nil)
        {
            NSString *nibName = [DeviceUtilities qualifiedNibNameForRootName:@"InstructionsView"];
            InstructionsViewController *instructionsViewController = [[InstructionsViewController alloc] initWithNibName:nibName bundle:nil];
            self.instructionsViewController = instructionsViewController;
            [instructionsViewController release];
        }

        // Set the frame size manually to fix a bug where switching views and
        // changing orientation shifts this new subview around
        self.instructionsViewController.view.frame = CGRectMake(0, 0, self.subview.frame.size.width, self.subview.frame.size.height);
        [self.subview addSubview:self.instructionsViewController.view];
    }
    else
    {        
        // Iterates through all files in the Documents directory
        for (NSString* file in [files objectEnumerator])
        {
            NSString *filePath = [[UpnpServer filePath] stringByAppendingPathComponent:file];
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
            
            BOOL isDirectory;
            [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            // Add the document URL to our list (ignore the "Inbox" folder)
            if (!(isDirectory && [file isEqualToString:@"Inbox"]))
            {
                [self.documentUrls addObject:fileUrl];
            }
        }
        
        if (self.filesViewController == nil)
        {
            NSString *nibName = [DeviceUtilities qualifiedNibNameForRootName:@"FilesView"];
            FilesViewController *filesViewController = [[FilesViewController alloc] initWithNibName:nibName bundle:nil];
            self.filesViewController = filesViewController;
            [filesViewController release];
        }

        self.filesViewController.documentUrls = self.documentUrls;
        [self.filesViewController.tableView reloadData];
        self.filesViewController.view.frame = CGRectMake(0, 0, self.subview.frame.size.width, self.subview.frame.size.height);
        [self.subview addSubview:self.filesViewController.view];
    }
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showingAboutView = NO;
    
    // Start monitoring the document directory
    NSMutableArray *documentUrls = [[NSMutableArray alloc] init];
    self.documentUrls = documentUrls;
    [documentUrls release];
    self.directoryWatcher = [DirectoryWatcher watchFolderWithPath:[UpnpServer filePath] delegate:self];
    
    // Switch views based on if files in directory
    [self directoryDidChange:self.directoryWatcher];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
