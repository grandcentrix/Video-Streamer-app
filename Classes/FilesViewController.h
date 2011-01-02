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


@interface FilesViewController : UIViewController <UIDocumentInteractionControllerDelegate,
                                                   UITableViewDelegate,
                                                   UITableViewDataSource>
{
    @private
        UITableView *tableView_;
        UIView *sectionHeaderView_;
        UILabel *sectionHeaderLabel_;
        UIDocumentInteractionController *docInteractionController_;
        NSArray *documentUrls_;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIView *sectionHeaderView;
@property (nonatomic, retain) IBOutlet UILabel *sectionHeaderLabel;
@property (nonatomic, retain) NSArray *documentUrls;

@end
