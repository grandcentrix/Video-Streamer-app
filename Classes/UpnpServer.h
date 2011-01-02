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

#include "PltUPnP.h"
#include "PltMediaConnect.h"
#include "PltVersion.h"
#include "PltMediaRenderer.h"


@interface UpnpServer : NSObject
{
    @private
        PLT_UPnP *upnp;
        PLT_MediaConnect *connect;
        NPT_Reference<PLT_FileMediaConnectDelegate> delegate;
}

+ (NSString *)filePath;
+ (NSArray *)documentsDirectoryContents;
- (void)start;
- (void)stop;
- (BOOL)isRunning;

@end
