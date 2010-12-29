#import <UIKit/UIKit.h>


@interface FilesViewController : UIViewController <UIDocumentInteractionControllerDelegate,
                                                   UITableViewDelegate,
                                                   UITableViewDataSource>
{
    @private
        UITableView *tableView_;
        UIDocumentInteractionController *docInteractionController_;
        NSArray *documentUrls_;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *documentUrls;

@end
