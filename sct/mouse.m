#import "mouse.h"
#import <QuartzCore/QuartzCore.h>
#import <AppKit/AppKit.h>

@implementation Mouse

+(void) registerMouse
{
    __block AXUIElementRef windowRef = nil;
    
    // get screen size
    NSRect screenRect;
    
    NSScreen *screen = [NSScreen mainScreen];
    screenRect = [screen frame];
    
    __block float oheight = screenRect.size.height;
    __block float deltaX;
    __block float deltaY;
    
    /*
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask  handler:^(NSEvent *mouseEvent) {
     
        if (throttle != 0) {
            throttle -= 1;
            return;
        }
        throttle = THROTTLE;
        NSLog(@"%@", NSStringFromPoint([mouseEvent locationInWindow]));
    }];
    */
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDraggedMask handler:^(NSEvent *mouseEvent) {
        NSPoint l = mouseEvent.locationInWindow;
        CGPoint upperLeft = { .x = l.x - deltaX, .y = oheight - l.y - deltaY };
        AXValueRef positionRef = AXValueCreate(kAXValueCGPointType, &upperLeft);
        AXUIElementSetAttributeValue(windowRef, kAXPositionAttribute, positionRef);
    }];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^(NSEvent *mouseEvent) {
        //
        [NSThread sleepForTimeInterval:0.1f];
    
        //
        NSRunningApplication *fma = [[NSWorkspace sharedWorkspace] frontmostApplication];
        
        //
        AXUIElementRef applicationRef = AXUIElementCreateApplication([fma processIdentifier]);
        CFArrayRef applicationWindows;
        AXUIElementCopyAttributeValues(applicationRef, kAXWindowsAttribute, 0, 100, &applicationWindows);
        windowRef = CFArrayGetValueAtIndex(applicationWindows, 0);
        
        AXValueRef position;
        CGPoint windowPosition;
        CGSize windowSize;
        CFTypeRef size;
        
        AXUIElementCopyAttributeValue(windowRef, kAXPositionAttribute, (CFTypeRef *)&position);
        AXValueGetValue(position, kAXValueCGPointType, &windowPosition);
        
        AXUIElementCopyAttributeValue(windowRef, (CFStringRef)NSAccessibilitySizeAttribute, &size);
        AXValueGetValue(size, kAXValueCGSizeType, &windowSize);
        NSLog(@"%f, %f", windowPosition.x, windowPosition.y);
        NSLog(@"%f, %f", windowSize.width, windowSize.height);
        
        
        
        
        
        /*
        // Get the graphics context that we are currently executing under
        NSGraphicsContext* gc = [NSGraphicsContext currentContext];
        
        // Save the current graphics context settings
        [gc saveGraphicsState];
        
        // Set the color in the current graphics context for future draw operations
        [[NSColor blackColor] setStroke];
        [[NSColor redColor] setFill];
        
        NSRect rect = NSMakeRect(windowPosition.x, windowPosition.y, windowSize.width, windowSize.height);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        
        // Outline and fill the path
        [circlePath stroke];
        [circlePath fill];
        
        
        [gc restoreGraphicsState];
        */
        
        
        NSRect frame = NSMakeRect(0, 0, 200, 200);
        NSUInteger styleMask =    NSBorderlessWindowMask;
        NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:styleMask];
        
        NSWindow * window =  [[NSWindow alloc] initWithContentRect:rect styleMask:styleMask backing: NSBackingStoreRetained    defer:false];
        [window setBackgroundColor:[NSColor blueColor]];
        [window display];
        
        
        
        deltaX = [mouseEvent locationInWindow].x - windowPosition.x;
        deltaY = (oheight - [mouseEvent locationInWindow].y) - windowPosition.y;
    }];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseUpMask handler:^(NSEvent *mouseEvent) {
    }];
    
}

@end
