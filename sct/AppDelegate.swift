import Cocoa

// @NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1) // NSVariableStatusItemLength

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusicon_default")
        icon?.template = true
        self.statusItem.image = icon
        
        HotKey.registerHotKey()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your applicationæ
    }


}