/*****************************************************************
 |
 |      Neptune - System Support: Cocoa Implementation
 |
 |      (c) 2002-2006 Gilles Boccon-Gibod
 |      Author: Sylvain Rebaud (sylvain@rebaud.com)
 |
 ****************************************************************/

/*----------------------------------------------------------------------
 |       includes
 +---------------------------------------------------------------------*/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>

#include "NptConfig.h"
#include "NptSystem.h"

/*----------------------------------------------------------------------
 |   NPT_System::GetMachineName
 +---------------------------------------------------------------------*/
NPT_Result
NPT_System::GetMachineName(NPT_String& name)
{
    // we need a pool because of UTF8String
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString* _name = [[UIDevice currentDevice] name];
    name = [(NSString *)_name UTF8String];
    [pool release];
    return NPT_SUCCESS;
}
