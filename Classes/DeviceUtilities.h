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

#import <Foundation/Foundation.h>


/**
 * Helper functions for managing iPad/iPhone devices
 */
@interface DeviceUtilities : NSObject
{

}

+ (BOOL)isiPad;
+ (NSString *)qualifiedNibNameForRootName:(NSString *)name;

@end
