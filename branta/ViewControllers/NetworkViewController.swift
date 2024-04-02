//
//  NetworkViewController.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa
import Foundation


// One NetworkViewController per wallet
// In each NetworkViewController instance, track:
// 1. PIDS
// 2. IPs that touch each PID in or out
// TrafficMonitor acts as delegate

class NetworkViewController: NSViewController, DataFeedObserver {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var walletName: NSTextField!
    
    var walletRuntime: String?
    
    func dataFeedExecutionDidFinish(success: Bool) {
        // TODO - get whether pw was accepted or not.
        if !success {
            if let window = view.window {
                window.close()
            }
        }
    }
    
    func dataFeedCount(count: Int) {
        let v = "\(walletRuntime!): \(count) Outbound Connections"
        walletName.stringValue = v
    }
        
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)
        
        walletName.stringValue = walletRuntime!
        walletName.font = NSFont(name: FONT, size: 19.0)

        
        let tm = TrafficMonitor(tableView: tableView, walletName: walletRuntime!)
        tableView.delegate = tm
        tableView.dataSource = tm
        tm.observer = self
        tm.runDataFeed()
        
//        walletName.stringValue = "\(walletRuntime!): \(tm.connections.count) Outbound Connections"
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = view.window {
            window.minSize = NSSize(width: 400, height: 320)
            window.titlebarAppearsTransparent = true
            window.title = ""
        }
    }
}
