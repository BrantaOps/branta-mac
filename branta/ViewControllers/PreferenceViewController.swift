//
//  PreferenceViewController.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Cocoa
import Foundation

class PreferenceViewController: NSViewController {
    
    let DEFAULT_CADENCE = 4
    let CADENCE_OPTIONS = [
        "1 Second",
        "5 Seconds",
        "10 Seconds",
        "30 Seconds",
        "60 Seconds",
        "5 Minutes",
        "10 Minutes",
        "30 Minutes"
    ]
    
    @IBOutlet weak var cadenceSelector: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCadence()
        configureSwitches()
    }
    
    @objc func setCadence(sender: NSPopUpButton) {
        if let selectedItem = sender.selectedItem {
            Preferences.set(key: "", value: selectedItem.title)
        }
    }
    
    @IBAction func setNotifyForBTCAddress(_ sender: Any) {
        if let uiSwitch = sender as? NSSwitch {
            print(uiSwitch.state)
        }
    }
    
    @IBAction func setNotifyForSeed(_ sender: Any) {
    }
    
    @IBAction func setNotifyForXPub(_ sender: Any) {
    }
    
    @IBAction func setNotifyForXPrv(_ sender: Any) {
    }
    
    
    @IBAction func setNotifyForNPub(_ sender: Any) {
    }
    
    
    @IBAction func setNotifyForNSec(_ sender: Any) {
    }
    
    @IBAction func setNotifyUponLaunch(_ sender: Any) {
    }
    
    @IBAction func setNotifyUponStatusChange(_ sender: Any) {
    }
    
    private
    
    func configureSwitches() {
        // TODO - startup
    }
    
    func configureCadence() {
        for cadence in CADENCE_OPTIONS {
            cadenceSelector.addItem(withTitle: cadence)
        }
        
        // TODO - startup
        cadenceSelector.selectItem(at: DEFAULT_CADENCE)
        cadenceSelector.target = self
        cadenceSelector.action = #selector(setCadence)
    }
}
