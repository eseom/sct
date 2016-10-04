#import "hotkey.h"

@implementation HotKey

EventHotKeyRef HotKeyRef;

+ (void)registerHotKey
{
    UInt32 keycode = 0;
    UInt32 hotKeyModifiers = 0;
    EventHotKeyID hotKeyId;
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    InstallApplicationEventHandler(&hotKeyHandler, 1, &eventType, NULL, NULL);
    hotKeyId.signature = 'sct1';
    hotKeyId.id = 1;
    keycode = 39;
    hotKeyModifiers = optionKey;
    RegisterEventHotKey(keycode,
                        hotKeyModifiers,
                        hotKeyId,
                        GetApplicationEventTarget(),
                        0,
                        &HotKeyRef);
    hotKeyId.signature = 'sct2';
    hotKeyId.id = 2;
    keycode = 41;
    hotKeyModifiers = optionKey;
    RegisterEventHotKey(keycode,
                        hotKeyModifiers,
                        hotKeyId,
                        GetApplicationEventTarget(),
                        0,
                        &HotKeyRef);

}

+ (void)unregisterHotKey
{
    UnregisterEventHotKey(HotKeyRef);
}

void newSafari() {
    NSAppleScript* safari = [[NSAppleScript alloc] initWithSource:
                               [NSString stringWithFormat:
                                @"do shell script \"open -a Safari\"\n"
                                @"tell application \"Safari\"\n"
                                @"do Javascript \"javascript:void(window.open('http://bbc.co.uk'))\" in document 1\n"
                                @"end tell"]];
    
    [safari executeAndReturnError:nil];
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
    EventHotKeyID sctCom;
    GetEventParameter(theEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(sctCom), NULL, &sctCom);
    int l = sctCom.id;
    switch (l) {
        case 1:
            newTerminal();
            break;
        case 2:
            newSafari();
            break;
        default:
            break;
    }
    return noErr;
}

@end
