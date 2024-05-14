//
//  TextFieldWithHover.swift
//  Branta
//
//  Created by Keith Gardner on 5/13/24.
//

import Cocoa
import Foundation

class TextFieldWithHover : NSTextField {
    override func resetCursorRects() {
        discardCursorRects()
        addCursorRect(self.bounds, cursor: NSCursor.pointingHand)
    }
}
