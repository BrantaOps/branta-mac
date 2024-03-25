//
//  Command.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Foundation

// Add another sudo param - make this a general UTIL, take it out of TM
class Command {
    class func runCommand(_ command: String) -> String? {
        let task = Process()
        task.launchPath = "/bin/sh"
        //        task.arguments = ["-c", command] // Non-sudo
        task.arguments = ["-c", "echo \(String(data: SudoUtil.pw!, encoding: .utf8)!) | sudo -S \(command)"] // with sudo
        
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        guard let outputString = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return outputString
    }
}
