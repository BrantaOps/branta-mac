//
//  Focus.swift
//  Branta
//
//  Created by Keith Gardner on 1/15/24.
//

import Cocoa

// TODO - this name is almost good.
// Focus is an automation that looks at which app is in the foreground, and if a bitcoin wallet, alerts status without having to leave
// branta main window open.
// "Foreground Automation?"

class Focus: Automation {
    
    private static var currentApp = ""
    private static var alreadyAlerted = ""
    
    override class func run() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            verify()
        }
    }
    
    private
    
    static func verify() {
        currentApp = getForegroundApplication()
        if APPS.contains(currentApp) {
            alertFor(app: currentApp)
        }
        else {
            alreadyAlerted = ""
        }
    }
    
    static func alertFor(app: String) {
        if app != alreadyAlerted {
            let verified = Verify.verify(wallet: app)
            let appDelegate = NSApp.delegate as? AppDelegate

            
            if verified {
                appDelegate?.notificationManager?.showNotification(
                    title: "\(app) Verified.",
                    body: "Safe to proceed.",
                    key: NOTIFY_UPON_LAUNCH
                )
                // TODO - these clauses need to check the version. see  https://github.com/BrantaOps/branta-mac/issues/53
            } else {
                appDelegate?.notificationManager?.showNotification(
                    title: "\(app) Unverified.",
                    body: "Your wallet may be compromised. Check Branta for details.",
                    key: NOTIFY_UPON_LAUNCH
                )
            }
            
            alreadyAlerted = app
        }
    }
    
    static func getForegroundApplication() -> String {
        if let app = NSWorkspace.shared.frontmostApplication {
            return app.localizedName!
        }
        return ""
    }
}
