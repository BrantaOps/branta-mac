//
//  MyKeyViewController.swift
//  Branta
//
//  Created by Keith Gardner on 6/24/24.
//

import Cocoa

class MyKeysViewController: NSViewController {
    private var tableData: [String:String] = [:]
    
    @IBOutlet weak var tableView: NSTableView!
    
    private let COLUMNS = [
        "NAME"              : 0,
        "XPUB"              : 1,
        "DELETE"            : 2,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pref = Settings.readFromDefaults()
        tableData = pref[XPUBS] as? [String:String] ?? [:]
        
        tableView.delegate      = self
        tableView.dataSource    = self
    }

    @IBAction func newKeys(_ sender: Any) {
        let appDelegate = NSApp.delegate as? AppDelegate
        
        NewKeyViewController.addObserver(self)
        
        if appDelegate?.newKeyWindow != nil {
            appDelegate?.newKeyWindow?.makeKeyAndOrderFront(nil)
            appDelegate?.newKeyWindow?.center()
            return
        }
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateController(withIdentifier: "newKeyWindow") as! NewKeyViewController
        let window = NSWindow(contentViewController: viewController)

        appDelegate?.newKeyWindow = window
        window.makeKeyAndOrderFront(nil)
        window.center()
    }
    
    @objc func deleteXPub(sender: NSClickGestureRecognizer) {

        if let clickedTextField = sender.view as? NSTextField {
            let alert = NSAlert()
            alert.messageText = "Confirmation"
            alert.informativeText = "Are you sure you want to proceed?"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Confirm")
            alert.addButton(withTitle: "Dismiss")
            
            let response = alert.runModal()
            
            if response == .alertFirstButtonReturn {
                let row             = tableView.row(for: clickedTextField)
                
                BrantaLogger.log(s: "Deleting \(row)")
                
                let keys = Array(tableData.keys).sorted()
                let key = keys[row]
                
                let pref = Settings.readFromDefaults()
                var xpubs = pref[XPUBS] as? [String:String] ?? [:]
                xpubs.removeValue(forKey: key)
                
                Settings.set(key: XPUBS, value: xpubs)
                
                tableData = xpubs
                tableView.reloadData()
            } else if response == .alertSecondButtonReturn {
                BrantaLogger.log(s: "Delete Dismissed.")
            }
        }
    }
}

extension MyKeysViewController: KeysObserver {
    func contentDidUpdate() {
        let pref = Settings.readFromDefaults()
        tableData = pref[XPUBS] as? [String:String] ?? [:]
        tableView.reloadData()
    }
}

extension MyKeysViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return HEIGHT
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnNumber = tableView.tableColumns.firstIndex(of: tableColumn!) else {
            return nil
        }
        
        // Force rewrite of the table. Don't care about cache.
        let textField = NSTextField()
        textField.identifier = NSUserInterfaceItemIdentifier("TextCell")
        textField.isEditable = false
        textField.bezelStyle = .roundedBezel
        textField.isBezeled = false
        textField.alignment = .center
        textField.font = NSFont(name: FONT, size: TABLE_FONT)
        
        let keys = Array(tableData.keys).sorted()
        let key = keys[row]
        let value = tableData[key] ?? ""
        
        if columnNumber == COLUMNS["NAME"] {
            textField.stringValue   = key
        } else if columnNumber == COLUMNS["XPUB"] {
            textField.stringValue   = value
        } else if columnNumber == COLUMNS["DELETE"] {
            
            let textField = TextFieldWithHover()
            textField.identifier = NSUserInterfaceItemIdentifier("TextCell")
            textField.isEditable = false
            textField.bezelStyle = .roundedBezel
            textField.isBezeled = false
            textField.alignment = .center
            textField.font = NSFont(name: FONT, size: TABLE_FONT)
            textField.textColor = NSColor(hex: RED)
            textField.stringValue   = "✕"
            let clickGesture        = NSClickGestureRecognizer(target: self, action: #selector(deleteXPub))
            textField.addGestureRecognizer(clickGesture)
            return textField
        }
        return textField
    }
}
