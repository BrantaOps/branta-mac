//
//  AppDelegate.swift
//  branta
//
//  Created by Keith Gardner on 11/17/23.
//

import Cocoa
import Countly

let FONT                    = "Avenir"
let GOLD                    = "#B1914A"
let RED                     = "#944545"
let GRAY                    = "#333130"
let ACTIVE                  = "Status: Active ✓"
let KEYCODE_COMMA           = 43

let APPS = [
    Sparrow.runtimeName(),
    Trezor.runtimeName(),
    Ledger.runtimeName(),
    BlockstreamGreen.runtimeName(),
    Wasabi.runtimeName(),
    Whirlpool.runtimeName()
]

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var mainWindowController: NSWindowController?
    var settingsWindow: NSWindow?
    var foreground: Bool = true
    var notificationManager: BrantaNotify?
    
    
    
    
    
    let AUTOMATIONS         = [Clipboard.self, Verify.self, Focus.self]
    let KEY_ABOUT           = "A"
    let KEY_SETTINGS        = "S"
    let KEY_QUIT            = "Q"

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //wipeDefaults() // For dev use
        start()
    }
    
    // Dock Icon Handler
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            openAboutWindow()
        }
        return true
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc func didTapAbout() {
        openAboutWindow()
    }
    
    @objc func didTapSettings() {
        openSettingsWindow()
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        foreground = true
    }

    func applicationDidResignActive(_ notification: Notification) {
        foreground = false
    }
    
    private
    
    func setupMenu(status:String) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        let statusItem = self.statusItem!
        let button = statusItem.button!
        button.image = NSImage(named: "menuicon")
        
        let menu = NSMenu()
        
        let aboutItem = NSMenuItem(title: "About", action: #selector(didTapAbout), keyEquivalent: KEY_ABOUT)
        menu.addItem(aboutItem)
        
        let authItem = NSMenuItem(title: status, action: nil, keyEquivalent: "")
        menu.addItem(authItem)
        
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(didTapSettings), keyEquivalent: KEY_SETTINGS)
        menu.addItem(settingsItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: KEY_QUIT))
        statusItem.menu = menu
    }
    
    func start() {
        startCountly()
                
        setupMenu(status: ACTIVE)
        if notificationManager == nil {
            notificationManager = BrantaNotify()
            notificationManager?.requestAuthorization()
        }
        
        for automation in AUTOMATIONS {
            automation.run()
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
            if event.modifierFlags.contains(.command), event.keyCode == KEYCODE_COMMA {
                openSettingsWindow()
            }
            return event
        }
        
        let pref = Settings.readFromDefaults()
        let showInDock = pref[SHOW_IN_DOCK] as? Bool
        
        if showInDock != nil && showInDock! {
            NSApp.setActivationPolicy(.regular)
        } else {
            NSApp.setActivationPolicy(.accessory)
        }
    }
    
    func startCountly() {
        let config: CountlyConfig = CountlyConfig()
        config.appKey = "ccc4eb59a850e5f3bdf640b8d36284c3bce03f12"
        config.host = "https://branta-0dc12e4ffb389.flex.countly.com"
        Countly.sharedInstance().start(with: config)
    }
    
    func wipeDefaults() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            dumpBrantaPrefs()
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
            print("Erased UserDefaults.")
        }
    }
    
    func dumpBrantaPrefs() {
        let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
        
        for (key, value) in defaultsDictionary {
            if (key == PREFS_KEY) {
                print("UserDefaults:\(key): \(value)")
            }
        }
    }
}
