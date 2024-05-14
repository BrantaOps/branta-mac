//
//  SettingsView.swift
//  Branta
//
//  Created by Keith Gardner on 3/3/24.
//

import Cocoa

class SettingsView: NSView {
    
    private let minimumHeight: CGFloat = 650
    private let minimumWidth: CGFloat = 400

    override var intrinsicContentSize: NSSize {
        var size = super.intrinsicContentSize
        size.width = max(size.width, minimumWidth)
        size.height = max(size.height, minimumHeight)
        return size
    }
}
