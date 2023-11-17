//
//  HashGrabber.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Cocoa
import Foundation

class HashGrabber {
    static var appDelegate: AppDelegate?
    private static var hashes: [[String : [String : String]]] = [] // Cached for duration of Branta
    
    static func grab() -> [[String : [String : String]]] {
        if hashes != [] {
            return hashes
        }
        
        if false { //&& isOnline() { // TODO - hit server to pull latest hashes.
            if isArm() {
                
            } else if isIntel() {
                
            }
        }
        else {
            if isArm() {
                hashes  = Verify.arm_HASHES
            } else if isIntel() {
                hashes  = Verify.x86_HASHES
            }
        }
        return hashes
    }
    
    private
    
//    static func isOnline() -> Bool {
//        if appDelegate == nil {
//            appDelegate = NSApp.delegate as? AppDelegate
//        }
//        return appDelegate!.hasInternet
//    }
    
    static func isArm() -> Bool {
        #if arch(arm64)
            return true
        #endif
        return false
    }
    
    static func isIntel() -> Bool {
        #if arch(x86_64)
            return true
        #endif
        return false
    }
}
