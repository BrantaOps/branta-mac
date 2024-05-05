//
//  Foreground.swift
//  Branta
//
//  Created by Keith Gardner on 1/15/24.
//

import Cocoa

class Foreground: BackgroundAutomation {
    
    private static var currentApp = ""
    private static var alreadyAlerted = ""
    private static let appDelegate = NSApp.delegate as? AppDelegate
    
    override class func run() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            checkForeground()
        }
    }
    
    private
    
    static func checkForeground() {
        currentApp = getForegroundApplication()
        if APPS.contains(currentApp) {
            alertFor(app: currentApp)
        }
        else {
            alreadyAlerted = ""
        }
    }
    
    static func getForegroundApplication() -> String {
        if let app = NSWorkspace.shared.frontmostApplication {
            return app.localizedName!
        }
        return ""
    }
        
    static func alertFor(app: String) {
        if (app == alreadyAlerted) { return }
        
        if checkStatus(wallet: app) {
            appDelegate?.notificationManager?.showNotification(
                title: "\(app) Verified.",
                body: "Safe to proceed.",
                key: NOTIFY_UPON_LAUNCH
            )
        } else {
            appDelegate?.notificationManager?.showNotification(
                title: "\(app) Unverified.",
                body: "Check Branta for details.",
                key: NOTIFY_UPON_LAUNCH
            )
        }
        
        alreadyAlerted = app
    }
    
    static func checkStatus(wallet: String) -> Bool {
        return Matcher.checkRuntime(
            hash: Sha.sha256ForDirectory(atPath: "/Applications/" + wallet + ".app"),
            wallet: "\(wallet).app"
        )
    }
}
