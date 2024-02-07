//
//  MenuHelper.swift
//  Branta
//
//  Created by Keith Gardner on 2/3/24.
//

import Cocoa
import Foundation

func openSettingsWindow() {
    let appDelegate = NSApp.delegate as? AppDelegate
    
    if appDelegate?.settingsWindow != nil {
        appDelegate?.settingsWindow?.makeKeyAndOrderFront(nil)
        appDelegate?.settingsWindow?.center()
        return
    }
    
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateController(withIdentifier: "pref") as! NSViewController
    let window = NSWindow(contentViewController: viewController)
    
    appDelegate?.settingsWindow = window

    window.makeKeyAndOrderFront(nil)
    window.center()
}

func openAboutWindow() {
    let appDelegate = NSApp.delegate as? AppDelegate
    
    if let window = appDelegate?.mainWindowController?.window {
        if !window.isVisible {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    } else {
        if let existingWindow = NSApp.mainWindow, existingWindow.isVisible {
            existingWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        } else {
            appDelegate?.mainWindowController = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
                .instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainWindowController"))
                as? NSWindowController

            appDelegate?.mainWindowController?.showWindow(nil)
        }
    }
}
