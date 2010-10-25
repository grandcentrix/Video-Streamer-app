#import <UIKit/UIKit.h>
#import "DirectoryWatcher.h"


@interface InstructionsViewController : UIViewController <DirectoryWatcherDelegate,
                                                          UIDocumentInteractionControllerDelegate,
                                                          UITableViewDelegate,
                                                          UITableViewDataSource>
{
    @private
        DirectoryWatcher *directoryWatcher_;
        NSMutableArray *documentUrls_;
        UIDocumentInteractionController *docInteractionController_;
        UIView *addFromiTunesView_;
        UITableView *tableView_;
}

@property (nonatomic, retain) IBOutlet UIView *addFromiTunesView;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
