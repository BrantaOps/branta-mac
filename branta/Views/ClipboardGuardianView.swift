//
//  ClipboardGuardianView.swift
//  Branta
//
//  Created by Keith Gardner on 5/4/24.
//

import Cocoa
import Foundation

class ClipboardGuardianView: NSView {

    private let IDLE_COLOR = NSColor(hex: BLACK)?.cgColor
    
    private let MIN_HEIGHT: CGFloat = 100
    private let MIN_WIDTH: CGFloat = 200

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.wantsLayer = true
        self.layer?.backgroundColor = IDLE_COLOR
        self.layer?.cornerRadius = 8

        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }
    
    
    override var intrinsicContentSize: NSSize {
        var size = super.intrinsicContentSize
        size.width = max(size.width, MIN_WIDTH)
        size.height = max(size.height, MIN_HEIGHT)
        
        return size
    }
}
