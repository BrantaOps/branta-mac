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
            // TODO 
            Preferences.set(key: "", value: selectedItem.title)
        }
    }
    
    @IBAction func setNotifyForBTCAddress(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_BTC_ADDRESS)
    }
    
    @IBAction func setNotifyForSeed(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_SEED)
    }
    
    @IBAction func setNotifyForXPub(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_XPUB)
    }
    
    @IBAction func setNotifyForXPrv(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_XPRV)
    }
    
    @IBAction func setNotifyForNPub(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_NPUB)
    }
    
    @IBAction func setNotifyForNSec(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_FOR_NSEC)
    }
    
    @IBAction func setNotifyUponLaunch(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_UPON_LAUNCH)
    }
    
    @IBAction func setNotifyUponStatusChange(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: NOTIFY_UPON_STATUS_CHANGE)
    }
    
    private
    
    func setFor(s: NSSwitch, key: String) {
        if s.state == .on {
            Preferences.set(key: key, value: true)
        } else {
            Preferences.set(key: key, value: false)
        }
    }
    
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
