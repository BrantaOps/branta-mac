//
//  SudoUtil.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Cocoa
import Foundation

let TEST_FOR_SUDO = "echo 'test for sudo.'"

class SudoUtil {
    static var isAuthenticated: Bool = false
    static var password: String?
    
    class func getPassword(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "Authentication Required"
            alert.informativeText = "Please enter your password to start monitoring connections."
            
            let passwordField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
            alert.accessoryView = passwordField
            
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")
            
            let response = alert.runModal()
            
            if response == .alertFirstButtonReturn {
                if let output = Command.runCommand(TEST_FOR_SUDO) {
                    if output == WRONG_PASSWORD {
                        completion(false)
                    } else {
                        self.password = passwordField.stringValue
                        completion(true)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
}
