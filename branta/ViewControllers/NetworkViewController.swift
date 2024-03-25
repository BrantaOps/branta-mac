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

class NetworkViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
        
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)

        let tm = TrafficMonitor()
        tableView.delegate = tm
        tableView.dataSource = tm
        tm.runDataFeed()
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
