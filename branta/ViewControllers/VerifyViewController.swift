//
//  VerifyViewController.swift
//  branta
//
//  Created by Keith Gardner on 12/22/23.
//

import Cocoa
import Foundation

let HEIGHT = 30.0
let TABLE_FONT = 17.0

class VerifyViewController: NSViewController, VerifyObserver, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var walletsDetected: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var tableData: Array<[String: String]> = []
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        Verify.addObserver(self)
        Verify.verify()
        
        if let window = view.window {
            window.minSize = NSSize(width: 400, height: 320)
            window.titlebarAppearsTransparent = true
            window.title = ""
         }
    }
    
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
         
        if columnNumber == 0 {
            let name = tableData[row]["name"]!.replacingOccurrences(of: ".app", with: "")
            textField.stringValue = name
        } else if columnNumber == 1 {
            if tableData[row]["match"] == "true" {
                textField.stringValue = "✓"
                textField.textColor = NSColor(hex: GOLD)
            }
            else {
                textField.stringValue = "⚠"
                textField.textColor = NSColor(hex: RED)
            }
            textField.font = NSFont(name: FONT, size: 20.0)
            let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(showDetails))
            textField.addGestureRecognizer(clickGesture)
        }
        return textField
    }
    
    @objc func showDetails(sender: NSClickGestureRecognizer) {
        
        if let clickedTextField = sender.view as? NSTextField {
            let row             = tableView.row(for: clickedTextField)
            let wallet          = tableData[row]
            let alert           = NSAlert()
            let name            = wallet["name"]!.replacingOccurrences(of: ".app", with: "")
            let version         = wallet["version"]!
            let nameKey         = wallet["name"]!
            let hashes          = HashGrabber.grab()[nameKey]!
            let versions        = hashes.keys
            
            alert.messageText   = "\(name) \(version)"
            alert.alertStyle = .informational
            alert.addButton(withTitle: "OK")
            
            if wallet["match"] == "true" {
                alert.informativeText = "Branta verified the validity of \(name)."
            } else if wallet["match"] != "true" && hashes[version] != nil {
                alert.informativeText = "Branta could not verify the validity of \(name). You should consider reinstalling the wallet from the publishers website."
            } else {
                var older = true
                var newer = true
                var comparisonResult: ComparisonResult
            
                // Pass through. All versions will be older OR newer.
                for brantaVersion in versions {
                    comparisonResult = compareVersions(version, brantaVersion)

                    if comparisonResult == .orderedAscending { newer = false }
                    else if comparisonResult == .orderedDescending { older = false }
                }
                
                if newer {
                    alert.informativeText = "An newer version of \(name) was detected than Branta knows about."
                }
                else if older {
                    alert.informativeText = "An outdated version of \(name) was detected. Branta can verify \(name) once you update the wallet."
                }
                else {
                    alert.informativeText = "An unknown version of \(name) was detected."
                }
            }
            
            alert.beginSheetModal(for: self.view.window!)
        }
    }
    
    func compareVersions(_ version1: String, _ version2: String) -> ComparisonResult {
        let components1 = version1.split(separator: ".").compactMap { Int($0) }
        let components2 = version2.split(separator: ".").compactMap { Int($0) }

        for (comp1, comp2) in zip(components1, components2) {
            if comp1 < comp2 {
                return .orderedAscending
            } else if comp1 > comp2 {
                return .orderedDescending
            }
        }

        // If all components are equal so far, compare the number of components
        return components1.count < components2.count ? .orderedAscending : .orderedSame
    }

    func verifyDidChange(newResults: Array<[String: String]>) {
        if newResults.count == 1 {
            walletsDetected.stringValue = "1 Wallet Detected."
        }
        else {
            walletsDetected.stringValue = "\(newResults.count) Wallets Detected."
        }
        tableData = newResults
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
