//
//  Command.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Foundation

class Command {
    class func runCommand(_ command: String, runAsSU: Bool=true) -> String? {
        let task = Process()
        task.launchPath = "/bin/sh"

        if runAsSU && SudoUtil.pw != nil {
            task.arguments = ["-c", "echo \(String(data: SudoUtil.pw!, encoding: .utf8)!) | sudo -S \(command)"]
        } else {
            task.arguments = ["-c", command]
        }
        
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
