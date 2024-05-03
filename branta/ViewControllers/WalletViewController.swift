//
//  WalletViewController.swift
//  Branta
//
//  Created by Keith Gardner on 5/3/24.
//

import Cocoa
import Foundation

class WalletViewController: NSViewController {
    var name: String = ""
    var status: WalletStatus = .SignatureMismatch
    
    // TODO - IBAction
    var txt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch status {
            case .TooNew:
                txt = "A newer version of \(name) was detected than Branta knows about."
            case .TooOld:
                txt = "An outdated version of \(name) was detected. Branta can verify \(name) once you update the wallet."
            case .UnknownVersion:
                txt = "An unknown version of \(name) was detected."
            case .SignatureMatch:
                txt = "Branta verified the validity of \(name)."
            case .SignatureMismatch:
                txt = ""
//            -            """
//            -            No match found. Don't panic, this could be for a few reasons:
//            -
//            -            - The wallet is older/newer than Branta knows about
//            -            - Branta is sensitive. Changing a single byte in the entire /Applications/Sparrow.app folder will trigger a mismatch
//            -            """
//            -            //
//            -            //                // In Mac, if you re-install from the sparrow website, the software will pickup your wallet data again.
//            -            //                // So its safe to update to the latest version.
//            -            //                // Drag and drop the PGP installer before this.
//            -            //
        }
    }
}
