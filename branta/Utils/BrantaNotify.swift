//
//  BrantaNotify.swift
//  branta
//
//  Created by Keith Gardner on 11/25/23.
//

import Foundation
import UserNotifications


class BrantaNotify: NSObject, UNUserNotificationCenterDelegate {
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        }
    }
    
    func showNotification(title: String, body: String, actionButtonTitle: String? = nil, key: String? = nil) {
        
        // Filter here
        let pref = Preferences.readFromDefaults()
        if key != nil && pref[key!] != nil {
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        if let actionButtonTitle = actionButtonTitle {
            let actionButton = UNNotificationAction(
                identifier: "action",
                title: actionButtonTitle,
                options: []
            )
            
            let category = UNNotificationCategory(
                identifier: "category",
                actions: [actionButton],
                intentIdentifiers: [],
                options: []
            )
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
            content.categoryIdentifier = "category"
        }
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
        }
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
