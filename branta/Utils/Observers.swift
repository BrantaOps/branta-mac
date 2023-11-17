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
