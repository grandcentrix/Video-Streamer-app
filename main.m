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

int main(int argc, char *argv[])
{    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
