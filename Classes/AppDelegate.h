#import <UIKit/UIKit.h>
#import "InstructionsViewController.h"
#import "UpnpServer.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    @private
        UIWindow *window_;
        UIViewController *viewController_;
        UpnpServer *upnpServer_;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;
@property (nonatomic, retain) UpnpServer *upnpServer;

@end

