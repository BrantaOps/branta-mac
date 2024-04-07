//
//  SettingsView.swift
//  Branta
//
//  Created by Keith Gardner on 3/3/24.
//

import Cocoa
import Foundation

class SettingsView: NSView {
    
    private let minimumHeight: CGFloat = 550
    private let minimumWidth: CGFloat = 500

    override var intrinsicContentSize: NSSize {
        var size = super.intrinsicContentSize
        size.width = max(size.width, minimumWidth)
        size.height = max(size.height, minimumHeight)
        return size
    }
    
}
