//
//  SudoUtil.swift
//  Branta
//
//  Created by Keith Gardner on 3/25/24.
//

import Cocoa
import Foundation

class SudoUtil {
    static var pw: Data?
    
    class func getPW(completion: @escaping (Data?) -> Void) {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "Authentication Required"
            alert.informativeText = "Please enter your password to start monitoring traffic."
            
            let passwordField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
            alert.accessoryView = passwordField
            
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")
            
            let response = alert.runModal()
            
            if response == .alertFirstButtonReturn {
                guard let password = passwordField.stringValue.data(using: .utf8) else {
                    print("Error: Unable to convert password to data")
                    completion(nil)
                    return
                }
                pw = password
                completion(password)
            } else {
                print("User cancelled authentication.")
                completion(nil)
            }
        }
    }
}
