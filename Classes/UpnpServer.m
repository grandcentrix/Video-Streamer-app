#import "UpnpServer.h"


@implementation UpnpServer


#pragma mark -
#pragma mark UpnpServer

- (id)init
{
    if ((self = [super init]))
    {
        // Set up Neptune logging
        NPT_LogManager::GetDefault().Configure("plist:.level=FINE;.handlers=ConsoleHandler;.ConsoleHandler.colors=off;.ConsoleHandler.filter=63");
    }
    
    return self;    
}

- (void)dealloc
{
    upnp.Stop();

    [super dealloc];
}

- (void)start
{
    // Set up device
    NSString *serverName = [UIDevice currentDevice].name;
    connect = new PLT_MediaConnect([serverName UTF8String]);
    connect->SetByeByeFirst(false);

    NSLog(@"FILEPATH:%@", [self filePath]);
    delegate = new PLT_FileMediaConnectDelegate("/", [[self filePath] UTF8String]);
    connect->SetDelegate((PLT_MediaServerDelegate*)delegate.AsPointer());

    // Set up UPnP server
    PLT_DeviceHostReference device(connect);
    upnp.AddDevice(device);
    upnp.Start();
}

- (void)stop
{
    upnp.Stop();
}

- (NSString *)filePath
{
    // Returns the Documents directory
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
