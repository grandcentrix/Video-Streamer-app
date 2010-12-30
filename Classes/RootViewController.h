#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "InstructionsViewController.h"
#import "FilesViewController.h"
#import "DirectoryWatcher.h"


@interface RootViewController : UIViewController <DirectoryWatcherDelegate>
{
    @private
        UIView *subview_;
        AboutViewController *aboutViewController_;
        InstructionsViewController *instructionsViewController_;
        FilesViewController *filesViewController_;
        DirectoryWatcher *directoryWatcher_;
        NSMutableArray *documentUrls_;
}

@property (nonatomic, retain) IBOutlet UIView *subview;
@property (nonatomic, retain) AboutViewController *aboutViewController;
@property (nonatomic, retain) InstructionsViewController *instructionsViewController;
@property (nonatomic, retain) FilesViewController *filesViewController;

-(IBAction)switchInfo:(id)sender;

@end
