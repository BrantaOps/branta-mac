//
//  TrafficMonitor.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa
import Foundation

class TrafficMonitor {
    func startMonitoring() {
        DispatchQueue.main.async {
            
            let alert = NSAlert()
            alert.messageText = "Authentication Required"
            alert.informativeText = "Please enter your password to start monitoring traffic."
            
            let passwordField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
            alert.accessoryView = passwordField
            
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")
            
            let response = alert.runModal()
            if response == .alertFirstButtonReturn { // OK button pressed
                guard let password = passwordField.stringValue.data(using: .utf8) else {
                    print("Error: Unable to convert password to data")
                    return
                }
                self.executeWithPassword(password)
            } else {
                print("User cancelled authentication.")
            }
        }
    }

    func executeWithPassword(_ password: Data) {
        DispatchQueue.global(qos: .background).async {
            
            let task = Process()
            task.launchPath = "/usr/bin/sudo"
            
            // TODO - look at en0, en1, etc
            
            // Args:
            // en1: use WiFi
            // -k: show PID
            task.arguments = ["-S", "/usr/sbin/tcpdump", "-i", "en1", "-n", "-vv", "-k"]
            
            let pipe = Pipe()
            task.standardInput = pipe
            
            let fileHandle = pipe.fileHandleForWriting
            fileHandle.write(password)
            fileHandle.closeFile()
            
            let outputPipe = Pipe()
            task.standardOutput = outputPipe
            
            let outputHandle = outputPipe.fileHandleForReading
            
            outputHandle.readabilityHandler = { pipe in
                if let output = String(data: pipe.availableData, encoding: .utf8) {
                    print(output)
                    print("------------------------")
                }
            }
            
            task.launch()
            task.waitUntilExit()
        }
    }
}


