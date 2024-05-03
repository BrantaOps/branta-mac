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
        "LAST_SCANNED"          : 1,
        "NETWORK_ACTIVITY"      : 2,
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
            let runtimeName = tableData[row].fullWalletName.replacingOccurrences(of: ".app", with: "")
            
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
        guard let clickedTextField = sender.view as? NSTextField else {
            return
        }
        
        let appDelegate         = NSApp.delegate as? AppDelegate
        if appDelegate?.walletWindow != nil {
            appDelegate?.walletWindow?.makeKeyAndOrderFront(nil)
            appDelegate?.walletWindow?.center()
            return
        }
        
        let wallet              = tableData[tableView.row(for: clickedTextField)]
        let name                = wallet.fullWalletName.replacingOccurrences(of: ".app", with: "")
        let version             = wallet.venderVersion
        let nameKey             = wallet.fullWalletName
        let hashes              = Bridge.getRuntimeHashes()[nameKey]!
        let versions            = hashes.keys

        
        
        let storyboard          = NSStoryboard(name: "Main", bundle: nil)
        let viewController      = storyboard.instantiateController(withIdentifier: "wallet") as! WalletViewController
        viewController.name     = name
        let window              = NSWindow(contentViewController: viewController)
        window.title            = "foobar"

                
        
        if wallet.brantaSignatureMatch {
            viewController.status = WalletStatus.SignatureMatch
        } else if !wallet.brantaSignatureMatch && hashes[version] != nil {
            viewController.status = WalletStatus.SignatureMismatch
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
                viewController.status = WalletStatus.TooNew
            }
            else if older {
                viewController.status = WalletStatus.TooOld
            }
            else {
                viewController.status = WalletStatus.UnknownVersion
            }
        }
        
        appDelegate?.walletWindow = window
        window.makeKeyAndOrderFront(nil)
        window.center()
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
        let name = tableData[row].fullWalletName.replacingOccurrences(of: ".app", with: "")
         
        if columnNumber == COLUMNS["WALLET_NAME"] {

            if tableData[row].brantaSignatureMatch {
                textField.stringValue   = "\(name): Verified ✓"
            }
            else {
                textField.stringValue   = "\(name): No Match Found ⚠"
            }
            

            let clickGesture            = NSClickGestureRecognizer(target: self, action: #selector(showDetails))
            textField.addGestureRecognizer(clickGesture)
        } else if columnNumber == COLUMNS["LAST_SCANNED"] {
            let currentTime         = Date()
            let dateFormatter       = DateFormatter()
            dateFormatter.timeStyle = .medium
            let formattedTime       = dateFormatter.string(from: currentTime)
            textField.stringValue   = formattedTime
            
            let clickGesture            = NSClickGestureRecognizer(target: self, action: #selector(showDetails))
            textField.addGestureRecognizer(clickGesture)
        } else if columnNumber == COLUMNS["NETWORK_ACTIVITY"] {
            textField.stringValue   = "View"
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
