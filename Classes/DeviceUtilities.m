#import "DeviceUtilities.h"


@implementation DeviceUtilities

+ (BOOL)isiPad
{
    BOOL isiPad = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        isiPad = YES;
    }
    
    return isiPad;
}

+ (NSString *)qualifiedNibNameForRootName:(NSString *)name
{
    NSMutableString *qualifiedName = [[[NSMutableString alloc] initWithString:name] autorelease];
    
    // Appends -iPad or -iPhone to the nib name based on the device
    if ([DeviceUtilities isiPad])
    {
        [qualifiedName appendString:@"-iPad"];
    }
    else
    {
        [qualifiedName appendString:@"-iPhone"];
    }
    
    return qualifiedName;
}

@end
