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
    
    private static var lastContent: String = "" {
        didSet {
            notifyObservers()
        }
    }
    
    override class func run() {
        // Construct word list, Notifications, etc.
        setup()
        
        // Keep trailing clipboard item.
        
        // Driver for clipboard related tasks
        Timer.scheduledTimer(withTimeInterval: CLIPBOARD_INTERVAL, repeats: true) { _ in
            let clipboardString = NSPasteboard.general.string
            let content = clipboardString(NSPasteboard.PasteboardType.string)
            
            if (content != lastContent && content != nil) {
                
                // TODO - order these and exit if one returns TRUE
                // Okay... lets just refactor this.
                //
                
                
                
                // Addresses                ----------------------------------------------
                checkForAddressesInClipBoard(content: content!)
                
                // Seed Phrases             ----------------------------------------------
                
                checkForSeedPhraseInClipBoard(content: content!)
                
                // Public & Private Keys    ----------------------------------------------
                
                //Bitcoin
                checkForXPUBInClipBoard(content: content!)
                checkForXPRVInClipBoard(content: content!)
                
                //NOSTR
                checkForNPUBInClipBoard(content: content!)
                checkForNSECInClipBoard(content: content!)
                
                lastContent = content!
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
            observer.contentDidChange(content: lastContent)
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
    
    static func checkForXPUBInClipBoard(content: String) {
        if BitcoinAddress.isValidXPUB(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "Bitcoin Extended Public Key in Clipboard.",
                body: "Sharing your XPUB can lead to loss of privacy.",
                key: NOTIFY_FOR_XPUB
            )
        }
    }
    
    static func checkForXPRVInClipBoard(content: String) {
        if BitcoinAddress.isValidXPRV(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "Bitcoin Private Key in Clipboard.",
                body: "Never share your private key with others.",
                key: NOTIFY_FOR_XPRV
            )
        }
    }
    
    static func checkForNPUBInClipBoard(content: String) {
        if NostrAddress.isValidNPUB(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "New Nostr Public Key in Clipboard.",
                body: "",
                key: NOTIFY_FOR_NPUB
            )
        }
    }
    
    static func checkForNSECInClipBoard(content: String) {
        if NostrAddress.isValidNSEC(str: content) {
            appDelegate?.notificationManager?.showNotification(
                title: "New Nostr Private Key in Clipboard.",
                body: "Never share your private key with others.",
                key: NOTIFY_FOR_NSEC
            )
        }
    }
    
    static func checkForSeedPhraseInClipBoard(content:String) {
        let hasWhitespace = content.rangeOfCharacter(from: .whitespacesAndNewlines)

        // Must have space or newlines between seed words
        if hasWhitespace == nil {
            return
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
            return
        }
        
        if (userSeedWords.isSubset(of: bip39WordSet!)) {
            appDelegate?.notificationManager?.showNotification(
                title: "Seed Phrase in clipboard detected.",
                body: "Never share your seed phrase with anyone. Your seed phrase IS your money.",
                key: NOTIFY_FOR_SEED
            )
        }
    }
    static func checkForAddressesInClipBoard(content:String) {
        
        let ret = self.validateAddress(content: content)
        
        if ret.valid {
            appDelegate?.notificationManager?.showNotification(
                title: "New Address in Clipboard.",
                body: ret.msg,
                key: NOTIFY_FOR_BTC_ADDRESS
            )
        }
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
