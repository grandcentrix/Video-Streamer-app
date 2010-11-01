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
        
        upnp = new PLT_UPnP();
        
        // Set up device
        NSString *serverName = [UIDevice currentDevice].name;
        connect = new PLT_MediaConnect([serverName UTF8String]);
        connect->SetByeByeFirst(false);
        
        NSLog(@"FILEPATH:%@", [UpnpServer filePath]);
        delegate = new PLT_FileMediaConnectDelegate("/", [[UpnpServer filePath] UTF8String]);
        connect->SetDelegate((PLT_MediaServerDelegate *)delegate.AsPointer());
        
        // Set up UPnP server
        PLT_DeviceHostReference device(connect);
        upnp->AddDevice(device);
    }
    
    return self;    
}

- (void)dealloc
{
    delete upnp;

    [super dealloc];
}

+ (NSString *)filePath
{
    // Returns the Documents directory
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSArray *)documentsDirectoryContents
{
    NSString *filePath = [UpnpServer filePath];
    
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
}

- (void)start
{
    upnp->Start();
}

- (void)stop
{
    upnp->Stop();
}

@end
