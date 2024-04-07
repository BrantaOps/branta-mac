//
//  HexColor.swift
//  branta
//
//  Created by Keith Gardner on 12/25/23.
//

import Cocoa

extension NSColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard hexSanitized.count == 6,
              Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let red = CGFloat((rgb & 0xFF0000) >> 16)
        let green = CGFloat((rgb & 0x00FF00) >> 8)
        let blue = CGFloat(rgb & 0x0000FF)

        guard red >= 0 && red <= 255,
              green >= 0 && green <= 255,
              blue >= 0 && blue <= 255 else {
            return nil
        }

        self.init(red: red / 255.0,
                  green: green / 255.0,
                  blue: blue / 255.0,
                  alpha: 1.0)
    }
}
