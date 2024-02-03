//
//  MenuHelper.swift
//  Branta
//
//  Created by Keith Gardner on 2/3/24.
//

import Cocoa
import Foundation

func openPreferencesWindow() {
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateController(withIdentifier: "pref") as! NSViewController
    let window = NSWindow(contentViewController: viewController)

    window.makeKeyAndOrderFront(nil)
    window.center()
}

// TODO - pull out all the menu launchers here


