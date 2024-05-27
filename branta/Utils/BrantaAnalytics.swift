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
        
        if let env = Env.loadEnv() {
            if let apiKey = env["API_KEY"], let host = env["HOST"] {
                // BrantaLogger.log(s: "API_KEY: \(apiKey)")
                // BrantaLogger.log(s: "HOST: \(host)")
                
                let config: CountlyConfig = CountlyConfig()
                config.appKey = apiKey
                config.host = host
                Countly.sharedInstance().start(with: config)

            }
        }
    }
}
