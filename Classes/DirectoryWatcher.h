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

@class DirectoryWatcher;

@protocol DirectoryWatcherDelegate <NSObject>
@required
- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher;
@end

@interface DirectoryWatcher : NSObject 
{
	id <DirectoryWatcherDelegate> delegate;
    
	int dirFD;
    int kq;
    
	CFFileDescriptorRef dirKQRef;
}
@property (nonatomic, assign) id <DirectoryWatcherDelegate> delegate;

+ (DirectoryWatcher *)watchFolderWithPath:(NSString *)watchPath delegate:(id<DirectoryWatcherDelegate>)watchDelegate;
- (void)invalidate;
@end