//
//  NetworkViewController.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa

class NetworkViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var walletName: NSTextField!
    
    var walletRuntime: String?
    var tm: TrafficMonitor?
        
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
        let appDelegate = NSApp.delegate as? AppDelegate
        appDelegate?.openedNetworkWindows[walletRuntime!] = nil
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

extension NetworkViewController: DataFeedObserver {
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
}
