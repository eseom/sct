import AppKit

autoreleasepool { () -> () in
    let application = NSApplication.sharedApplication()
    let delegate = AppDelegate()
    application.delegate = delegate
    application.run()
}