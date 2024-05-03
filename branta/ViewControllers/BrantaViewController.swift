//
//  BrantaViewController.swift
//  branta
//
//  Created by Keith Gardner on 12/22/23.
//

import Cocoa


class CustomAlertWindow: NSWindow {
    convenience init(wallet: String, status: WalletStatus) {
        let windowSize = NSSize(width: 400, height: 200)
        let contentRect = NSRect(origin: .zero, size: windowSize)
        
        self.init(contentRect: contentRect, styleMask: [.titled, .closable], backing: .buffered, defer: false)
        self.title = wallet
        self.isReleasedWhenClosed = true
        self.center()
        
        let contentView = NSView(frame: contentRect)
        self.contentView = contentView

        var txt = ""
        switch status {
        case .TooNew:
            txt = "A newer version of \(wallet) was detected than Branta knows about."
        case .TooOld:
            txt = "An outdated version of \(wallet) was detected. Branta can verify \(wallet) once you update the wallet."
        case .UnknownVersion:
            txt = "An unknown version of \(wallet) was detected."
        case .SignatureMatch:
            txt = "Branta verified the validity of \(wallet)."
        case .SignatureMismatch:
            txt =
            """
            No match found. Don't panic, this could be for a few reasons:
            
            - The wallet is older/newer than Branta knows about
            - Branta is sensitive. Changing a single byte in the entire /Applications/Sparrow.app folder will trigger a mismatch
            """
            //
            //                // In Mac, if you re-install from the sparrow website, the software will pickup your wallet data again.
            //                // So its safe to update to the latest version.
            //                // Drag and drop the PGP installer before this.
            //
        }

        let label = NSTextField(labelWithString: txt)
        label.frame = contentView.bounds
        label.maximumNumberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        contentView.addSubview(label)
    }
}



// Dial this in - 100%
enum WalletStatus {
    case TooOld
    case TooNew
    case UnknownVersion
    case SignatureMatch
    case SignatureMismatch
}

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
        
        let wallet              = tableData[tableView.row(for: clickedTextField)]
        let name                = wallet.fullWalletName.replacingOccurrences(of: ".app", with: "")
        let version             = wallet.venderVersion
        let nameKey             = wallet.fullWalletName
        let hashes              = Bridge.getRuntimeHashes()[nameKey]!
        let versions            = hashes.keys
        var customAlertWindow: CustomAlertWindow?
        
        if wallet.brantaSignatureMatch {
            customAlertWindow = CustomAlertWindow(
                wallet: name,
                status: WalletStatus.SignatureMatch
            )
        } else if !wallet.brantaSignatureMatch && hashes[version] != nil {
            customAlertWindow = CustomAlertWindow(
                wallet: name,
                status: WalletStatus.SignatureMismatch
            )
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
                customAlertWindow = CustomAlertWindow(
                    wallet: name,
                    status: WalletStatus.TooNew
                )
            }
            else if older {
                customAlertWindow = CustomAlertWindow(
                    wallet: name,
                    status: WalletStatus.TooOld
                )
            }
            else {
                customAlertWindow = CustomAlertWindow(
                    wallet: name,
                    status: WalletStatus.TooOld
                )
            }
        }
        
        customAlertWindow?.makeKeyAndOrderFront(nil)
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
