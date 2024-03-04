//
//  SettingsView.swift
//  Branta
//
//  Created by Keith Gardner on 3/3/24.
//

import Foundation

import Cocoa

class SettingsView: NSView {
    
    let minimumHeight: CGFloat = 550
    let minimumWidth: CGFloat = 500

    override var intrinsicContentSize: NSSize {
        var size = super.intrinsicContentSize
        size.width = max(size.width, minimumWidth)
        size.height = max(size.height, minimumHeight)
        return size
    }
    
}
