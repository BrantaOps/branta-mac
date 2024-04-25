//
//  AppDelegate.swift
//  branta
//
//  Created by Keith Gardner on 11/17/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem?
    var mainWindowController: NSWindowController?
    var settingsWindow: NSWindow?
    var foreground: Bool = true
    var notificationManager: BrantaNotify?
    var openedNetworkWindows: [String: NSWindowController] = [:]
    
    private let AUTOMATIONS         = [Clipboard.self, Verify.self, Foreground.self]
    private let KEY_ABOUT           = "A"
    private let KEY_SETTINGS        = "S"
    private let KEY_QUIT            = "Q"
    private let KEY_UPDATE          = "U"
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //wipeDefaults() // For dev use
        start()
    }
    
    // Dock Icon Handler
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            MenuHelper.openAboutWindow()
        }
        return true
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        foreground = true
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        foreground = false
    }
    
    @objc func didTapAbout() {
        MenuHelper.openAboutWindow()
    }
    
    @objc func didTapSettings() {
        MenuHelper.openSettingsWindow()
    }
    
    @objc func getUpdate(_ sender: NSMenuItem) {
        if let tag = sender.representedObject {
            BrantaLogger.log(s: "Fetching tag: \(tag)")
            let github = "https://github.com/BrantaOps/branta-mac/releases/download/\(tag)/Branta-\(tag).dmg.zip"
            if let url = URL(string: github) {
                NSWorkspace.shared.open(url)
            }
        }
    }
}

extension AppDelegate {
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
        
        Updater.checkForUpdates { updatesAvailable, tag in
            if updatesAvailable {
                let updateItem = NSMenuItem(title: "Update Available", action: #selector(self.getUpdate(_:)), keyEquivalent: self.KEY_UPDATE)
                updateItem.representedObject = tag
                menu.addItem(updateItem)
            } else {
                // TODO. For now, let the user know branta is up to date.
                // But we should mention something about the manifest/runtime hashes later.
                let updateItem = NSMenuItem(title: "Latest Version", action: nil, keyEquivalent: "")
                menu.addItem(updateItem)
            }
        }
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: KEY_QUIT))
        statusItem.menu = menu
    }
    
    func start() {
        BrantaAnalytics.start()
                
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
                MenuHelper.openSettingsWindow()
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
    
    func wipeDefaults() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            dumpBrantaPrefs()
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
            BrantaLogger.log(s: "Erased UserDefaults.")
        }
    }
    
    func dumpBrantaPrefs() {
        let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
        
        for (key, value) in defaultsDictionary {
            if (key == PREFS_KEY) {
                BrantaLogger.log(s: "UserDefaults:\(key): \(value)")
            }
        }
    }
}
