//
//  TrafficMonitor.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa
import Foundation

class TrafficMonitor: Automation {
    
    var tableView: NSTableView
    var parentPID: Int                  = -1
    var pids: Array<Int>                = []
    var connections: Array<Connection>  = []
    var walletName:String?
    weak var observer: DataFeedObserver?

    // TODO - this should be a user preference.
    let CADENCE = 3.0
    
    let COLUMNS = [
        "PID": 0,
        "IP": 1,
    ]
    
    init(tableView: NSTableView, walletName: String) {
        self.walletName = walletName
        self.tableView = tableView
        super.init()
    }
    
    override func runDataFeed() {
        if SudoUtil.pw != nil {
            self.execute()
            observer?.dataFeedExecutionDidFinish(success: true)
        } else {
            SudoUtil.getPW { password in
                if password == nil {
                    self.observer?.dataFeedExecutionDidFinish(success: false)
                }
                else {
                    self.execute()
                    self.observer?.dataFeedExecutionDidFinish(success: true)
                }
            }
        }
    }

    private
    
    func execute() {
        (self.parentPID, self.pids) = PIDUtil.collectPIDs(appName: self.walletName!)
        self.getConnections()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        Timer.scheduledTimer(withTimeInterval: CADENCE, repeats: true) { _ in
            (self.parentPID, self.pids) = PIDUtil.collectPIDs(appName: self.walletName!)
            self.getConnections()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Parse output of each PID. Not every PID talks over the network.
    func parseOutput(_ output: String) {
        if output == "" {
            return
        }
        
        let lines = output.components(separatedBy: "\n")
        
        for line in lines {
            let processedLine = line.removeExtraSpaces()
            let components = processedLine.components(separatedBy: .whitespaces)

            if components.count > 8 && components[0] != "COMMAND" {
                let command         = components[0]
                let pid             = components[1]
                let user            = components[2]
                let fileDescriptor  = components[3]
                let type            = components[4]
                let device          = components[5]
                let sizeOffset      = components[6]
                let node            = components[7]
                let name            = components[8]
                
                let connection = Connection(command: command, pid: pid, user: user, fileDescriptor: fileDescriptor, type: type, device: device, sizeOffset: sizeOffset, node: node, name: name)
                
                if !(connections.contains(where: {
                    $0.name == connection.name
                 })) {
                    connections.append(connection)
                }
                
            }

        }
    }

    func getConnections() {
        for pid in pids {
            if let output = Command.runCommand("sudo lsof -i -a -p \(pid) -n") {
                parseOutput(output)
            }
        }
    }
}

extension TrafficMonitor: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnNumber = tableView.tableColumns.firstIndex(of: tableColumn!) else {
            return nil
        }
        
        // Force rewrite of the table. Don't care about cache.
        let textField = NSTextField()
        textField.identifier = NSUserInterfaceItemIdentifier("TextCell")
        textField.isEditable = false
        textField.bezelStyle = .roundedBezel
        textField.isBezeled = false
        textField.alignment = .center
        textField.font = NSFont(name: FONT, size: TABLE_FONT)
         
        if columnNumber == COLUMNS["PID"] {
            textField.stringValue = connections[row].pid
        } else if columnNumber == COLUMNS["IP"] {
            textField.isEditable = true
            textField.stringValue = connections[row].name
        }
        return textField
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return connections.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return HEIGHT
    }
}
