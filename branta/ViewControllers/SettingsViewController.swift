//
//  SettingsViewController.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Cocoa

class SettingsViewController: NSViewController {
    
    @IBOutlet weak var cadenceSelector: NSPopUpButton!
    
    @IBOutlet weak var notifyForBTCAddressOutlet: NSSwitch!
    @IBOutlet weak var notifyForSeedOutlet: NSSwitch!
    @IBOutlet weak var notifyForXPubOutlet: NSSwitch!
    @IBOutlet weak var notifyForXPrvOutlet: NSSwitch!
    @IBOutlet weak var notifyForNPubOutlet: NSSwitch!
    @IBOutlet weak var notifyForNSecOutlet: NSSwitch!
    @IBOutlet weak var notifyUponLaunchOutlet: NSSwitch!
    @IBOutlet weak var notifyUponStatusChangeOutlet: NSSwitch!
    @IBOutlet weak var showInDockOutlet: NSSwitch!
    @IBOutlet weak var lastSyncLabel: NSTextField!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        configureCadence()
        configureSwitches()
        BrantaLogger.log(s: Settings.readFromDefaults())
        
        if let window = view.window {
            window.titlebarAppearsTransparent = true
            window.title = ""
        }
    }
    
    @objc func setCadence(sender: NSPopUpButton) {
        Settings.set(key: SCAN_CADENCE_WORDING, value: CADENCE_OPTIONS[sender.indexOfSelectedItem].0)
        Settings.set(key: SCAN_CADENCE,         value: CADENCE_OPTIONS[sender.indexOfSelectedItem].1)
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
    
    @IBAction func setShowInDock(_ sender: Any) {
        setFor(s: sender as! NSSwitch, key: SHOW_IN_DOCK)
        
        if (sender as! NSSwitch).state == .on {
            NSApp.setActivationPolicy(.regular)
        } else {
            NSApp.setActivationPolicy(.accessory)
        }
        
        NSApplication.shared.activate(ignoringOtherApps: true)
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
            } else if setting.key == SHOW_IN_DOCK {
                BrantaLogger.log(s: "settings \(SHOW_IN_DOCK) to \(setting.value)")
                showInDockOutlet.state = setting.value as! Bool == true ? .on : .off
            }
            
        }
    }
    
    func configureCadence() {
        let settings = Settings.readFromDefaults()
        
        for cadence in CADENCE_OPTIONS {
            cadenceSelector.addItem(withTitle: cadence.0)
        }
        
        // TODO - engine hooks, cold start
        let cadenceStr = settings[SCAN_CADENCE_WORDING] as! String
        if let index = CADENCE_OPTIONS.firstIndex(where: { $0.0 == cadenceStr }) {
            cadenceSelector.selectItem(at: index)
        }
        
        cadenceSelector.target = self
        cadenceSelector.action = #selector(setCadence)
    }
}
