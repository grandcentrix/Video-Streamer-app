#include "PltUPnP.h"
#include "PltMediaConnect.h"
#include "PltVersion.h"
#include "PltMediaRenderer.h"


@interface UpnpServer : NSObject
{
    @private
        PLT_UPnP *upnp;
        PLT_MediaConnect *connect;
        NPT_Reference<PLT_FileMediaConnectDelegate> delegate;
}

+ (NSString *)filePath;
+ (NSArray *)documentsDirectoryContents;
- (void)start;
- (void)stop;
- (BOOL)isRunning;

@end
