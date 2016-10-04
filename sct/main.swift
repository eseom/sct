import AppKit

autoreleasepool { () -> () in
    let application = NSApplication.shared()
    let delegate = AppDelegate()
    application.delegate = delegate
    application.run()
}
