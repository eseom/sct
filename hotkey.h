#ifndef sct_hotkey_h
#define sct_hotkey_h

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface HotKey : NSObject

+ (void)registerHotKey;
+ (void)unregisterHotKey;

@end

#endif
