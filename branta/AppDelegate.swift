//
//  AppDelegate.swift
//  branta
//
//  Created by Keith Gardner on 11/17/23.
//

import Cocoa

let FONT                    = "Avenir"
let GOLD                    = "#B1914A"
let RED                     = "#944545"
let GRAY                    = "#333130"

let ACTIVE                  = "Status: Active ✓"

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
    var foreground: Bool = true
    var notificationManager: NotificationManager?
    
    let AUTOMATIONS         = [Clipboard.self, Verify.self, Focus.self]
    let KEY_ABOUT           = "A"
    let KEY_STATUS          = "S"
    let KEY_PREFERENCES     = "P"
    let KEY_QUIT            = "Q"

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
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
    
    @objc func didTapPreferences() {
        openPreferencesWindow()
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        foreground = true
    }

    func applicationDidResignActive(_ notification: Notification) {
        foreground = false
    }
    
    private

    func openAboutWindow() {
        if let window = mainWindowController?.window {
            if !window.isVisible {
                window.makeKeyAndOrderFront(nil)
                NSApp.activate(ignoringOtherApps: true)
            }
        } else {
            if let existingWindow = NSApp.mainWindow, existingWindow.isVisible {
                // If the main window is already visible, make it key and order it front
                existingWindow.makeKeyAndOrderFront(nil)
                NSApp.activate(ignoringOtherApps: true)
            } else {
                // If the main window is not yet created or nil, you can create and show it
                mainWindowController = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
                    .instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainWindowController"))
                    as? NSWindowController

                mainWindowController?.showWindow(nil)
            }
        }
    }
    
    func setupMenu(status:String) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        let statusItem = self.statusItem!
        let button = statusItem.button!
        button.image = NSImage(named: "menuicon")
        
        let menu = NSMenu()
        
        let aboutItem = NSMenuItem(title: "About", action: #selector(didTapAbout), keyEquivalent: KEY_ABOUT)
        menu.addItem(aboutItem)
        
        let authItem = NSMenuItem(title: status, action: nil, keyEquivalent: KEY_STATUS)
        menu.addItem(authItem)
        
        let prefItem = NSMenuItem(title: "Preferences", action: #selector(didTapPreferences), keyEquivalent: KEY_PREFERENCES)
        menu.addItem(prefItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: KEY_QUIT))
        statusItem.menu = menu
    }
    
    func start() {
        setupMenu(status: ACTIVE)
        if notificationManager == nil {
            notificationManager = NotificationManager()
            notificationManager?.requestAuthorization()
        }
        
        for automation in AUTOMATIONS {
            automation.run()
        }
    }
}
