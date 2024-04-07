//
//  PID.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Cocoa
import Foundation

class PIDUtil {
    
    class func getParentPID(appName: String) -> Int {
        let runningApps = NSWorkspace.shared.runningApplications
        for app in runningApps {
            if app.localizedName == appName {
                return Int(app.processIdentifier)
            }
        }
        return -1
    }
    
    class func getChildPIDs(parentPID: Int) -> [Int] {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "ps -o pid,ppid -ax | awk '{ if ($2 == \(parentPID)) print $1 }'"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        guard let outputString = String(data: data, encoding: .utf8) else {
            return []
        }
        
        var childPIDs = outputString.split(separator: "\n").compactMap { Int($0) }
        childPIDs.append(parentPID)
        return childPIDs
    }
}
