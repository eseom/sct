#import "window.h"

@implementation Window
+(void) registerWindow
{
    // NSLog(@"%@", [NSRunningApplication currentApplication]);
    NSArray *t = [[NSWorkspace sharedWorkspace] runningApplications];
    for (id object in t) {
        AXUIElementRef applicationRef = AXUIElementCreateApplication([object processIdentifier]);
        CFArrayRef applicationWindows;
        AXUIElementCopyAttributeValues(applicationRef, kAXWindowsAttribute, 0, 100, &applicationWindows);
        if (!applicationWindows) continue;
        NSLog(@"%@, %@", applicationRef, applicationWindows);
        
        
        AXUIElementRef windowRef = CFArrayGetValueAtIndex(applicationWindows, 0);
        
        // CGPoint point = windowRef->point;
    }
//    NSLog(@"%@", object);
}
@end
