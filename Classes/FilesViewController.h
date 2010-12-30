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
