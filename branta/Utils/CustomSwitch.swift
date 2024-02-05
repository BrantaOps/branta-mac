//
//  CustomSwitch.swift
//  Branta
//
//  Created by Keith Gardner on 2/3/24.
//

import Cocoa
import Foundation

class CustomSwitch: NSSwitch {
   
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Check if the switch is in the "on" state
        if state == .on {
            print("custom on")
            // Set the color for the "on" state
            NSColor.green.setFill() // Change this to the desired color

            // Draw a rounded rectangle representing the "on" state
            let path = NSBezierPath(roundedRect: bounds, xRadius: 16, yRadius: 16)
            path.fill()
        }
        else {
            print("custom else")
        }
    }
    
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        self.appearance = NSAppearance(named: .aqua)
////        self.contentTintColor = NSColor(hex: GOLD)
//        self.window?.colorSpace = NSColor(hex: GOLD)
//    }
}

