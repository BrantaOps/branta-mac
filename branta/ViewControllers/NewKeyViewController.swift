//
//  NewKeyViewController.swift
//  Branta
//
//  Created by Keith Gardner on 6/24/24.
//

import Cocoa

class NewKeyViewController: NSViewController {
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var keyField: NSTextField!
    
    @IBAction func saveKey(_ sender: Any) {
        guard BitcoinAddress.isValidXPUB(str: keyField.stringValue) else {
            return
        }
        
        if var keys = Settings.readFromDefaults()[XPUBS] as? [String:String] {
            keys[nameField.stringValue] = keyField.stringValue
            Settings.set(key: XPUBS, value: keys)
        } else {
            let keys = [nameField.stringValue: keyField.stringValue]
            Settings.set(key: XPUBS, value: keys)
        }
        NewKeyViewController.notifyObservers()
    }
}

// OBSERVER ------------------------------------------------------------------------------------------
extension NewKeyViewController {
    private static var observers = [KeysObserver]()

    static func addObserver(_ observer: KeysObserver) {
        observers.append(observer)
    }
    
    static func removeObserver(_ observer: KeysObserver) {
        observers.removeAll { $0 === observer }
    }
    
    static func notifyObservers() {
        for observer in observers {
            observer.contentDidUpdate()
        }
    }
}
