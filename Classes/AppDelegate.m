#import "AppDelegate.h"


@implementation AppDelegate

@synthesize window = window_;
@synthesize viewController = viewController_;
@synthesize upnpServer = upnpServer_;


#pragma mark -
#pragma mark AppDelegate

- (void)dealloc
{
    [upnpServer_ release];
    [window_ release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Do not sleep
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // Load the view
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    
    // Start the UPnP server
    UpnpServer *upnpServer = [[UpnpServer alloc] init];
    self.upnpServer = upnpServer;
    [upnpServer release];
    
    [self.upnpServer start];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Re-start the UPnP server
    if (self.upnpServer == nil)
    {
        UpnpServer *upnpServer = [[UpnpServer alloc] init];
        self.upnpServer = upnpServer;
        [upnpServer release];        
    }
    
    [self.upnpServer start];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Stop the UPnP server
    [self.upnpServer stop];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Stop the UPnP server
    [self.upnpServer stop];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


@end
