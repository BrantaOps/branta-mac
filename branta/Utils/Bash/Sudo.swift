//
//  SudoUtil.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Cocoa

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
                // User entered a password. Assign the value & check for correctness.
                self.password = passwordField.stringValue
                
                if let output = Command.runCommand(TEST_FOR_SUDO) {
                    // We tried the password and it was wrong - clear field.
                    if output == WRONG_PASSWORD {
                        self.password = nil
                        completion(false)
                    } else {
                        // We tried the password and it was correct - auth & complete.
                        self.isAuthenticated = true
                        completion(true)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
}
