//
//  DropView.swift
//  Branta
//
//  Created by Keith Gardner on 1/29/24.
//

import Cocoa

class DropView: NSView {

    // Mac users will mostly use .dmg, but branta
    // can also be used to verify an installer for other platforms.
    let ALLOWED_EXTENSIONS = [
        "dmg",
        "rpm",
        "tar.gz",
        "gz",
        "zip",
        "deb",
        "exe"
    ]
    let LIVE_COLOR = NSColor.darkGray.cgColor
    let IDLE_COLOR = NSColor(hex: GRAY)?.cgColor

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.wantsLayer = true
        self.layer?.backgroundColor = IDLE_COLOR

        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
  
        NSColor.darkGray.setStroke()
        let borderWidth: CGFloat = 3.0
        
        let path = NSBezierPath(rect: bounds)
        let pattern: [CGFloat] = [10.0, 10.0]
        
        path.setLineDash(pattern, count: 2, phase: 0.0)
        path.lineWidth = borderWidth
        path.stroke()
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = LIVE_COLOR
            return .copy
        } else {
            return NSDragOperation()
        }
    }

    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
              let path = board[0] as? String
        else { return false }

        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in ALLOWED_EXTENSIONS {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = IDLE_COLOR
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = IDLE_COLOR
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
              let path = pasteboard[0] as? String
        else { return false }

        let match = Installer.check(path: path)
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        if match.0 {
            alert.messageText   = "Verified \(match.1) ✓"
            alert.informativeText = "Branta matched the authors PGP-verified checksum."
        }
        else {
            alert.messageText   = "Could Not Verify ⚠"
            alert.informativeText = "The .dmg did not match any checksums known to Branta."
        }
        
        alert.beginSheetModal(for: window!)
        return true
    }
}
