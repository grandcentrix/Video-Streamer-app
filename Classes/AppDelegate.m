#import "AppDelegate.h"


@implementation AppDelegate

@synthesize window = window_;
@synthesize viewController = viewController_;
@synthesize upnpServer = upnpServer_;


#pragma mark -
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

#pragma mark AppDelegate

- (void)dealloc
{
    [upnpServer_ release];
    [window_ release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Do not sleep
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // Load the view
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    
    // Start the UPnP server
    UpnpServer *upnpServer = [[UpnpServer alloc] init];
    self.upnpServer = upnpServer;
    [upnpServer release];
    
    [self.upnpServer start];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Re-start the UPnP server
    if (self.upnpServer == nil)
    {
        UpnpServer *upnpServer = [[UpnpServer alloc] init];
        self.upnpServer = upnpServer;
        [upnpServer release];        
    }
    
    [self.upnpServer start];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Stop the UPnP server
    [self.upnpServer stop];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Stop the UPnP server
    [self.upnpServer stop];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


@end
