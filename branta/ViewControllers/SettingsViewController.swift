//
//  SettingsViewController.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Cocoa
import Foundation

class SettingsViewController: NSViewController {
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
        
    @IBOutlet weak var notifyForBTCAddressOutlet: NSSwitch!
    @IBOutlet weak var notifyForSeedOutlet: NSSwitch!
    @IBOutlet weak var notifyForXPubOutlet: NSSwitch!
    @IBOutlet weak var notifyForXPrvOutlet: NSSwitch!
    @IBOutlet weak var notifyForNPubOutlet: NSSwitch!
    @IBOutlet weak var notifyForNSecOutlet: NSSwitch!
    @IBOutlet weak var notifyUponLaunchOutlet: NSSwitch!
    @IBOutlet weak var notifyUponStatusChangeOutlet: NSSwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        configureCadence()
        configureSwitches()
        print(Settings.readFromDefaults())
    }
    
    @objc func setCadence(sender: NSPopUpButton) {
        Settings.set(key: SCAN_CADENCE, value: sender.indexOfSelectedItem)
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
            Settings.set(key: key, value: true)
        } else {
            Settings.set(key: key, value: false)
        }
    }
    
    func configureSwitches() {
        let settings = Settings.readFromDefaults()
        
        for setting in settings {
            if setting.key == NOTIFY_FOR_BTC_ADDRESS {
                notifyForBTCAddressOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_FOR_SEED {
                notifyForSeedOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_FOR_XPUB {
                notifyForXPubOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_FOR_XPRV {
                notifyForXPrvOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_FOR_NPUB {
                notifyForNPubOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_FOR_NSEC {
                notifyForNSecOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_UPON_LAUNCH {
                notifyUponLaunchOutlet.state = setting.value as! Bool == true ? .on : .off
            } else if setting.key == NOTIFY_UPON_STATUS_CHANGE {
                notifyUponStatusChangeOutlet.state = setting.value as! Bool == true ? .on : .off
            }
        }
    }
    
    func configureCadence() {
        let settings = Settings.readFromDefaults()
        let cadence = settings[SCAN_CADENCE] as! Int

        for cadence in CADENCE_OPTIONS {
            cadenceSelector.addItem(withTitle: cadence)
        }
        
        // TODO - engine hooks, cold start
        cadenceSelector.selectItem(at: cadence)
        cadenceSelector.target = self
        cadenceSelector.action = #selector(setCadence)
    }
}
