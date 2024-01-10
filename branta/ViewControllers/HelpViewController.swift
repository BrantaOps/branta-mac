//
//  HelpViewController.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

import Cocoa
import Foundation


class HelpViewController: NSViewController {
    
    @IBOutlet weak var q1: NSTextField!
    @IBOutlet weak var a1: NSTextField!
    
    @IBOutlet weak var q2: NSTextField!
    @IBOutlet weak var a2: NSTextField!
    
    @IBOutlet weak var link: NSTextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseFont = NSFont(name: FONT, size: 19.0)!
        let boldFont = NSFontManager.shared.convert(baseFont, toHaveTrait: .boldFontMask)
        
        q1.font = boldFont
        a1.font = NSFont(name: FONT, size: 15.0)
        q2.font = boldFont
        a2.font = NSFont(name: FONT, size: 15.0)
        link.font = NSFont(name: FONT, size: 15.0)
    }
}
