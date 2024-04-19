//
//  BrantaLogger.swift
//  Branta
//
//  Created by Keith Gardner on 4/6/24.
//

import Foundation

class BrantaLogger {
    class func log(s: Any, timestamp: Bool = false){
        if timestamp {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: currentDate)
            
            print("\(dateString): \(s)")
        }
        else {
            print(s)
        }
    }
}
