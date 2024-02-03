//
//  PreferenceViewController.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Cocoa
import Foundation

class PreferenceViewController: NSViewController {

    @IBOutlet weak var clipboardNotifyBTCAddress: NSSwitch!
    @IBOutlet weak var runEverySeconds: NSPopUpButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO - Dict with constants
        runEverySeconds.addItem(withTitle: "1 Second")
        runEverySeconds.addItem(withTitle: "5 Seconds")
        runEverySeconds.addItem(withTitle: "10 Seconds")
        runEverySeconds.addItem(withTitle: "30 Seconds")
        runEverySeconds.addItem(withTitle: "60 Seconds")
        runEverySeconds.addItem(withTitle: "5 Minutes")
        runEverySeconds.addItem(withTitle: "10 Minutes")
        runEverySeconds.addItem(withTitle: "30 Minutes")
        
        runEverySeconds.selectItem(at: 4)
        
        
        runEverySeconds.target = self
        runEverySeconds.action = #selector(runEverySelected)
    }
    
    @objc func runEverySelected(sender: NSPopUpButton) {
        if let selectedItem = sender.selectedItem {
            print("Selected number: \(selectedItem.title)")
        }
    }
    
}
