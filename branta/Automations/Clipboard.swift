//
//  Clipboard.swift
//  branta
//
//  Created by Keith Gardner on 11/20/23.
//

import Cocoa

class Clipboard: BackgroundAutomation {
    
    private static var bip39WordSet : Set<String>?
    private static let appDelegate = NSApp.delegate as? AppDelegate
    private static var lastContent: String = ""
    private static var guardianText: String = "" { didSet { notifyObservers() } }
    private static var labelText: String = "" { didSet { notifyObservers() } }

    
    override class func run() {
        setup()
        
        Timer.scheduledTimer(withTimeInterval: CLIPBOARD_INTERVAL, repeats: true) { _ in
            guard let clipboardString = NSPasteboard.general.string(forType: .string),
                  clipboardString != lastContent else {
                return
            }
            
            lastContent = clipboardString
            
            if checkForAddressesInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Single use Bitcoin Address detected."
                guardianText = clipboardString
            }
            else if checkForXPUBInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Extended Public Key Detected."
                guardianText = clipboardString
            }
            else if checkForNPUBInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Nostr Public Key Detected."
                guardianText = clipboardString
            }
            else if checkForNSECInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Nostr Private Key Detected."
                guardianText = ""
            }
            else if checkForSeedPhraseInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Seed Phrase Detected."
                guardianText = ""
            }
            else if checkForXPRVInClipBoard(content: clipboardString) {
                labelText = "Clipboard: Bitcoin Private Key Detected."
                guardianText = ""
            }
            else {
                labelText = "Clipboard"
                guardianText = "No Bitcoin/Nostr content detected."
            }
        }
    }
}

extension Clipboard {
    private static var observers = [ClipboardObserver]()

    static func addObserver(_ observer: ClipboardObserver) {
        observers.append(observer)
    }
    
    static func removeObserver(_ observer: ClipboardObserver) {
        observers.removeAll { $0 === observer }
    }
    
    static func notifyObservers() {
        for observer in observers {
            observer.contentDidChange(content: guardianText, labelText: labelText)
        }
    }
}

extension Clipboard {
    
    private
    
    static func setup() {
        let path = Bundle.main.path(forResource: "bip39wordlist", ofType: "txt")
        let words = try? String(contentsOfFile: path!)
        bip39WordSet = Set(words!.components(separatedBy: "\n"))
    }
    
    static func checkForXPUBInClipBoard(content: String) -> Bool {
        if BitcoinAddress.isValidXPUB(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "Bitcoin Extended Public Key in Clipboard.",
                body: "Sharing your XPUB can lead to loss of privacy.",
                key: NOTIFY_FOR_XPUB
            )
            return true
        }
        
        return false
    }
    
    static func checkForXPRVInClipBoard(content: String) -> Bool {
        if BitcoinAddress.isValidXPRV(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "Bitcoin Private Key in Clipboard.",
                body: "Never share your private key with others.",
                key: NOTIFY_FOR_XPRV
            )
            return true
        }
        
        return false
    }
    
    static func checkForNPUBInClipBoard(content: String) -> Bool {
        if NostrAddress.isValidNPUB(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "New Nostr Public Key in Clipboard.",
                body: "",
                key: NOTIFY_FOR_NPUB
            )
            return true
            
        }
        return false
    }
    
    static func checkForNSECInClipBoard(content: String) -> Bool {
        if NostrAddress.isValidNSEC(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "New Nostr Private Key in Clipboard.",
                body: "Never share your private key with others.",
                key: NOTIFY_FOR_NSEC
            )
            return true
        }
        
        return false
    }
    
    static func checkForSeedPhraseInClipBoard(content:String) -> Bool {
        let hasWhitespace = content.rangeOfCharacter(from: .whitespacesAndNewlines)

        // Must have space or newlines between seed words
        if hasWhitespace == nil {
            return false
        }
        
        // Naive, but check that each item is a BIP39.
        let spaced = content.components(separatedBy: " ")
        let newlined = content.components(separatedBy: "\n")
        var userSeedWords: Set<String> = []
        
        // Deduce seedwords from \n or " "
        if (spaced.count > newlined.count) {
            userSeedWords = Set(spaced)
        }
        else if (newlined.count > spaced.count){
            userSeedWords = Set(newlined)
        }
        
        // TODO - case this case, the line broke, its a valid seed with \n on a line. Strip each word of \n.
//        ["actor", "absent", "absurd", "across", "actress", "acquire", "absorb", "accident", "action", "abandon", "accuse", "able", "actual\n", "abuse", "act", "account", "above", "acoustic", "access", "about", "achieve", "abstract", "acid", "ability"]
        
        // Check quantity
        if (userSeedWords.count < SEED_WORDS_MIN || userSeedWords.count > SEED_WORDS_MAX) {
            return false
        }
        
        if (userSeedWords.isSubset(of: bip39WordSet!)) {
            appDelegate?.notificationManager?.showNotification(
                title: "Seed phrase words detected in clipboard.",
                body: "Never share your seed phrase with anyone.",
                key: NOTIFY_FOR_SEED
            )
            return true
        }
        return false
    }
    static func checkForAddressesInClipBoard(content:String) -> Bool {
        
        let ret = self.validateAddress(content: content)
        
        if ret.valid {
            appDelegate?.notificationManager?.showNotification(
                title: "New Address in Clipboard.",
                body: ret.msg,
                key: NOTIFY_FOR_BTC_ADDRESS
            )
            return true
        }
        return false
    }
    
    static func validateAddress(content: String?) -> (valid: Bool, msg: String) {
        if content == nil {
            return (valid: false, msg: "")
        }
        
        let isBitcoin = BitcoinAddress.isValid(str: content!)
                
        if isBitcoin {
            return (valid: true, msg: "Bitcoin detected.")
        }
        else {
            return (valid: false, msg: "")
        }
    }
}
