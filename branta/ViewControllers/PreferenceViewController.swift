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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pref loaded")
    }
}
