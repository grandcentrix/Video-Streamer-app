#import <Foundation/Foundation.h>


/**
 * Helper functions for managing iPad/iPhone devices
 */
@interface DeviceUtilities : NSObject
{

}

+ (BOOL)isiPad;
+ (NSString *)qualifiedNibNameForRootName:(NSString *)name;

@end
