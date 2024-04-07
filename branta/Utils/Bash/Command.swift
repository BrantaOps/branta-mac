//
//  Command.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Foundation

class Command {
    
    private static let PW_FEEDBACK  = "Sorry, try again."
    private static let BASH         = "/bin/sh"
    
    class func runCommand(_ command: String, runAsSU: Bool=true) -> String? {
        let task            = Process()
        task.launchPath     = BASH

        if runAsSU {
            if SudoUtil.isAuthenticated || command == TEST_FOR_SUDO {
                task.arguments = ["-c", "echo \(SudoUtil.password!) | sudo -S \(command)"]
            } else {
                print("Command#runCommand must have sudo auth before running as SU.")
                return WRONG_PASSWORD
            }
        } else {
            task.arguments  = ["-c", command]
        }
        
        let pipe            = Pipe()
        task.standardOutput = pipe
        let errorPipe       = Pipe()
        task.standardError  = errorPipe
        
        task.launch()
        
        let outputData      = pipe.fileHandleForReading.readDataToEndOfFile()
        let errorData       = errorPipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()

        let errorString     = String(data: errorData, encoding: .utf8)
        let outputString    = String(data: outputData, encoding: .utf8)
        
        if errorString != nil && (errorString!.contains(PW_FEEDBACK)) {
            return WRONG_PASSWORD
        }
        
        return outputString
    }
}
