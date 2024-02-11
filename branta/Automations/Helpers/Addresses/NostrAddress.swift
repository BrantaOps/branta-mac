import Foundation

//https://github.com/nostr-protocol/nips/blob/master/19.md

class NostrAddress {
    
    static func isValidNPUB(str: String) -> Bool {
        let npubAddressRegex = try! NSRegularExpression(pattern: "^npub[0-9a-z]{58,65}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: str.utf16.count)
        let match = npubAddressRegex.firstMatch(in: str, options: [], range: range) != nil
        
        return match
    }
    
    static func isValidNSEC(str: String) -> Bool {
        let npubAddressRegex = try! NSRegularExpression(pattern: "^nsec[0-9a-z]{58,65}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: str.utf16.count)
        let match = npubAddressRegex.firstMatch(in: str, options: [], range: range) != nil
        
        return match
    }
}
