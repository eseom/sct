#import "hotkey.h"

@implementation HotKey

EventHotKeyRef hotKeyRef;

+ (void)registerHotKey
{
    UInt32 keycode = 0;
    UInt32 hotKeyModifiers = 0;
    EventHotKeyID hotKeyId;
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    InstallApplicationEventHandler(&hotKeyHandler, 1, &eventType, NULL, NULL);
    hotKeyId.signature = 'eeee';
    hotKeyId.id = 0;
    keycode = 39;
    hotKeyModifiers = optionKey;
    RegisterEventHotKey(keycode,
                        hotKeyModifiers,
                        hotKeyId,
                        GetApplicationEventTarget(),
                        0,
                        &hotKeyRef);
    // [[AllkdicManager sharedInstance] open];
}

+ (void)unregisterHotKey
{
    UnregisterEventHotKey(hotKeyRef);
}

void newTerminal() {
    NSAppleScript* terminal = [[NSAppleScript alloc] initWithSource:
                               [NSString stringWithFormat:
                                @"tell application \"Terminal\"\n"
                                    @"if it is not running then\n"
                                        @"reopen\n"
                                        @"activate\n"
                                    @"else if length of (get every window) is not 0 then\n"
                                        @"reopen\n"
                                        @"activate\n"
                                        @"do script \"\"\n"
                                    @"else\n"
                                        @"reopen\n"
                                        @"activate\n"
                                    @"end if\n"
                                @"end tell"]];
    
    [terminal executeAndReturnError:nil];
}

#pragma mark -
#pragma mark HotKey

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
    newTerminal();
    return noErr;
}

@end