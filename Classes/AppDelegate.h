#import <UIKit/UIKit.h>
#import "InstructionsViewController.h"
#import "UpnpServer.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    @private
        UIWindow *window_;
        InstructionsViewController *viewController_;
        UpnpServer *upnpServer_;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InstructionsViewController *viewController;
@property (nonatomic, retain) UpnpServer *upnpServer;

@end

