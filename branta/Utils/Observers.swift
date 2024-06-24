//
//  Observers.swift
//  branta
//
//  Created by Keith Gardner on 12/25/23.
//

protocol VerifyObserver: AnyObject {
    func verifyDidChange(newResults: [CrawledWallet])
}

protocol DataFeedObserver: AnyObject {
    func dataFeedExecutionStarted(started: Bool)
    func dataFeedCount(count: Int)
}

protocol ClipboardObserver: AnyObject {
    func contentDidChange(content: Any?, labelText: String)
}

protocol BridgeObserver: AnyObject {
    func bridgeDidFetch(content: String)
}

protocol KeysObserver: AnyObject {
    func contentDidUpdate()
}
