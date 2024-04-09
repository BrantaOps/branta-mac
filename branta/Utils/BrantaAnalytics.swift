//
//  BrantaAnalytics.swift
//  Branta
//
//  Created by Keith Gardner on 4/9/24.
//

import Countly
import Foundation

class BrantaAnalytics {
    
    class func start() {
        let config: CountlyConfig = CountlyConfig()
        config.appKey = "ccc4eb59a850e5f3bdf640b8d36284c3bce03f12"
        config.host = "https://branta-0dc12e4ffb389.flex.countly.com"
        Countly.sharedInstance().start(with: config)
    }
}
