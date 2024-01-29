//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//


class Installer: Automation {
    
    // API to start ongoing monitors
    override class func run() {
        // No op, this is manually kicked off
    }
    
    // API to toggle automation
    override class func disable() {
        // Not implemented
    }
    
    // API to present UI to user (for manual .dmg PGP check on install)
    override class func present() {
        
    }
}
