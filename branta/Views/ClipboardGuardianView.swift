//
//  ClipboardGuardianView.swift
//  Branta
//
//  Created by Keith Gardner on 5/4/24.
//

import Cocoa
import Foundation

class ClipboardGuardianView: NSView {
    
    private var contentsLabel: NSTextField!

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hex: GRAY)?.cgColor
        self.layer?.cornerRadius = 8
        
        contentsLabel = NSTextField(labelWithString: "")
        contentsLabel.alignment = .center
        contentsLabel.textColor = .white
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false

        contentsLabel.lineBreakMode = .byWordWrapping // Wrap to new line when needed
        contentsLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) // Allow horizontal compression
        contentsLabel.setContentHuggingPriority(.defaultLow, for: .horizontal) // Allow horizontal expansion
        
        
        self.addSubview(contentsLabel)
        
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50), // Add top padding
            contentsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4), // Add leading padding
            contentsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4), // Add trailing padding
            contentsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4) // Add bottom padding
        ])
    }

    func updateLabel(str: String) {
        contentsLabel.stringValue = str
    }
}
