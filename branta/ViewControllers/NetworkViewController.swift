//
//  NetworkViewController.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa
import Foundation

class NetworkViewController: NSViewController, DataFeedObserver {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var walletName: NSTextField!
    
    var walletRuntime: String?
    var tm: TrafficMonitor?

    
    func dataFeedExecutionStarted(started: Bool) {
        if !started {
            if let window = view.window {
                window.close()
            }
        }
    }
    
    func dataFeedCount(count: Int) {
        walletName.stringValue = "\(walletRuntime!): \(count) Connections"
    }
        
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.appearance = NSAppearance(named: .darkAqua)
        
        walletName.stringValue = walletRuntime!
        walletName.font = NSFont(name: FONT, size: 19.0)
        
        tm = TrafficMonitor(tableView: tableView, walletName: walletRuntime!)
        tableView.delegate = tm
        tableView.dataSource = tm
        tm?.observer = self
        tm?.runDataFeed()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        tm?.stopDataFeed()
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
