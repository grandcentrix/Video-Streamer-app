#import <UIKit/UIKit.h>
#import "UpnpServer.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    @private
        UIWindow *window_;
        UpnpServer *upnpServer_;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UpnpServer *upnpServer;

@end

