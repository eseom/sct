import Cocoa

// @NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.system().statusItem(withLength: -1) // NSVariableStatusItemLength

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "statusicon_default")
        icon?.isTemplate = true
        self.statusItem.image = icon
        
        HotKey.register()
        Mouse.register()
//        Window.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your applicationæ
    }


}
