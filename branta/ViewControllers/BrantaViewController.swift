//
//  BrantaViewController.swift
//  branta
//
//  Created by Keith Gardner on 12/22/23.
//

import Cocoa

class BrantaViewController: NSViewController {
    @IBOutlet weak var walletsDetected: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    private var tableData: [CrawledWallet] = []

    private let COLUMNS = [
        "WALLET_NAME"           : 0,
        "STATUS"                : 1,
        "LAST_SCANNED"          : 2,
        "NETWORK_ACTIVITY"      : 3,
    ]
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        Bridge.fetchLatest { success in
            if success {
                Verify.addObserver(self)
                Verify.verify()
            } else {
                BrantaLogger.log(s: "BrantaViewController; could not start `Verify.verify()`.")
            }
        }

        
        if let window = view.window {
            window.minSize = NSSize(width: 400, height: 320)
            window.titlebarAppearsTransparent = true
            window.title = ""
         }
    }

    
    @objc func viewNetwork(sender: NSClickGestureRecognizer) {
        if let clickedTextField = sender.view as? NSTextField {
            let appDelegate = NSApp.delegate as? AppDelegate
            let row = tableView.row(for: clickedTextField)
            let runtimeName = tableData[row].name.replacingOccurrences(of: ".app", with: "")
            
            if let existingWindowController = appDelegate?.openedNetworkWindows[runtimeName] {
                existingWindowController.window?.makeKeyAndOrderFront(nil)
            } else {
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                guard let newViewController = storyboard.instantiateController(withIdentifier: "networkVC") as? NetworkViewController else {
                    fatalError("Unable to instantiate new view controller")
                }
                
                newViewController.walletRuntime = runtimeName
                
                let newWindowController = NSWindowController(window: NSWindow(contentViewController: newViewController))
                newWindowController.showWindow(nil)
                
                appDelegate?.openedNetworkWindows[runtimeName] = newWindowController
            }

        }
    }
    
    @objc func showDetails(sender: NSClickGestureRecognizer) {
        
        if let clickedTextField = sender.view as? NSTextField {
            let row             = tableView.row(for: clickedTextField)
            let wallet          = tableData[row]
            let alert           = NSAlert()
            let name            = wallet.name.replacingOccurrences(of: ".app", with: "")
            let version         = wallet.version
            let nameKey         = wallet.name
            let hashes          = Bridge.getRuntimeHashes()[nameKey]!
            let versions        = hashes.keys
            
            alert.messageText   = "\(name) \(version)"
            alert.alertStyle = .informational
            alert.addButton(withTitle: "OK")
            
            if wallet.match == "true" {
                alert.informativeText = "Branta verified the validity of \(name)."
            } else if wallet.match != "true" && hashes[version] != nil {
                alert.informativeText = "Branta could not verify the validity of \(name). You should consider reinstalling the wallet from the publishers website."
            } else {
                var older = true
                var newer = true
                var comparisonResult: ComparisonResult
            
                // Pass through. All versions will be older OR newer.
                for brantaVersion in versions {
                    do {
                        comparisonResult = try VersionComp.compare(version, brantaVersion)
                        if comparisonResult == .orderedAscending { newer = false }
                        else if comparisonResult == .orderedDescending { older = false }
                    } catch {
                        BrantaLogger.log(s: "BrantaViewController#showDetails error: \(error)")
                    }
                }
                
                if newer {
                    alert.informativeText = "A newer version of \(name) was detected than Branta knows about."
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
}


extension BrantaViewController: NSTableViewDelegate, NSTableViewDataSource {
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
        let name = tableData[row].name.replacingOccurrences(of: ".app", with: "")
         
        if columnNumber == COLUMNS["WALLET_NAME"] {
            textField.stringValue = name
        } else if columnNumber == COLUMNS["STATUS"] {
            if tableData[row].match == "true" {
                textField.stringValue   = "✓"
                textField.textColor     = NSColor(hex: GOLD)
            }
            else {
                textField.stringValue   = "⚠"
                textField.textColor     = NSColor(hex: RED)
            }
            textField.font              = NSFont(name: FONT, size: 20.0)
            let clickGesture            = NSClickGestureRecognizer(target: self, action: #selector(showDetails))
            textField.addGestureRecognizer(clickGesture)
        } else if columnNumber == COLUMNS["LAST_SCANNED"] {
            let currentTime         = Date()
            let dateFormatter       = DateFormatter()
            dateFormatter.timeStyle = .medium
            let formattedTime       = dateFormatter.string(from: currentTime)
            textField.stringValue   = formattedTime
        } else if columnNumber == COLUMNS["NETWORK_ACTIVITY"] {
            textField.stringValue   = "View"
            textField.font          = NSFont(name: FONT, size: 20.0)
            let clickGesture        = NSClickGestureRecognizer(target: self, action: #selector(viewNetwork))
            textField.addGestureRecognizer(clickGesture)
        }
        return textField
    }
}

extension BrantaViewController: VerifyObserver {
    // Lets hide this... adds noise to homescreen
    func verifyDidChange(newResults: [CrawledWallet]) {
        if newResults.count == 0 {
            walletsDetected.isHidden = false
            walletsDetected.stringValue = "0 Wallets Detected."
        }
        if newResults.count == 1 {
            walletsDetected.isHidden = true
            walletsDetected.stringValue = "1 Wallet Detected."
        }
        else {
            walletsDetected.isHidden = true
            walletsDetected.stringValue = "\(newResults.count) Wallets Detected."
        }
        tableData = newResults
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
