//
//  Observers.swift
//  branta
//
//  Created by Keith Gardner on 12/25/23.
//

import Foundation


protocol VerifyObserver: AnyObject {
    func verifyDidChange(newResults: Array<[String: String]>)
}

protocol DataFeedObserver: AnyObject {
    func dataFeedExecutionDidFinish(success: Bool)
    func dataFeedCount(count: Int)
}
