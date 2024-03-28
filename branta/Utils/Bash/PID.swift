//
//  PID.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Cocoa
import Foundation

class PIDUtil {
    class func collectPIDs(appName: String) -> (Int, Array<Int>) {
        print("Running PIDUtil#collectPIDs")
        var pids: [Int] = []
        var parentPID = -1
        
        let runningApps = NSWorkspace.shared.runningApplications
        for app in runningApps {
            if app.localizedName == appName {
                parentPID = Int(app.processIdentifier)
                print("Set parentPID \(parentPID)")
                pids.append(parentPID)
                
                
                let childPIDs = getChildPIDs(ofParentPID: pid_t(parentPID))
                print("Child PIDs:", childPIDs)
                for pid in childPIDs {
                    pids.append(Int(pid))
                }
            }
        }
        print("PIDUtil#pids = \(pids)")
        return (parentPID, pids)
    }
    
    class func getChildPIDs(ofParentPID parentPID: pid_t) -> [pid_t] {
        print("Running PIDUtil#getChildPIDs")
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
        
        let childPIDs = outputString.split(separator: "\n").compactMap { pid_t($0) }
        return childPIDs
    }
}
