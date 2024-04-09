import Foundation

//https://github.com/nostr-protocol/nips/blob/master/19.md

class NostrAddress {
    static let npubRegex = try! NSRegularExpression(pattern: "^npub[0-9a-z]{58,65}$", options: .caseInsensitive)
    static let nsecRegex = try! NSRegularExpression(pattern: "^nsec[0-9a-z]{58,65}$", options: .caseInsensitive)
    
    static func isValidNPUB(str: String) -> Bool {
        let range = NSRange(location: 0, length: str.utf16.count)
        
        return npubRegex.firstMatch(in: str, options: [], range: range) != nil
    }
    
    static func isValidNSEC(str: String) -> Bool {
        let range = NSRange(location: 0, length: str.utf16.count)
        
        return nsecRegex.firstMatch(in: str, options: [], range: range) != nil
    }
}
