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

#import "DeviceUtilities.h"


@implementation DeviceUtilities

+ (BOOL)isiPad
{
    BOOL isiPad = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        isiPad = YES;
    }
    
    return isiPad;
}

+ (NSString *)qualifiedNibNameForRootName:(NSString *)name
{
    NSMutableString *qualifiedName = [[[NSMutableString alloc] initWithString:name] autorelease];
    
    // Appends -iPad or -iPhone to the nib name based on the device
    if ([DeviceUtilities isiPad])
    {
        [qualifiedName appendString:@"-iPad"];
    }
    else
    {
        [qualifiedName appendString:@"-iPhone"];
    }
    
    return qualifiedName;
}

@end
