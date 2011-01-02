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
#import "InstructionsViewController.h"
#import "UpnpServer.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    @private
        UIWindow *window_;
        UIViewController *viewController_;
        UpnpServer *upnpServer_;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;
@property (nonatomic, retain) UpnpServer *upnpServer;

@end

