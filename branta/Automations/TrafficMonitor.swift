//
//  TrafficMonitor.swift
//  Branta
//
//  Created by Keith Gardner on 3/19/24.
//

import Cocoa
import Foundation

struct Connection {
    var command: String
    var pid: String
    var user: String
    var fileDescriptor: String
    var type: String
    var device: String
    var sizeOffset: String
    var node: String
    var name: String
}

class TrafficMonitor: Automation {
    
    var parentPID: Int = -1
    var pids: Array<Int> = []
    var ips: Array<Int> = []

    let walletName = "Ledger Live"
    
    
    override func runDataFeed() {
        
        if SudoUtil.pw != nil {
            self.execute()
        } else {
            SudoUtil.getPW { password in
                if password != nil {
                    self.execute()
                    print("after execute call")
                }
            }
        }
    }

    private
    
    func execute() {
        print("running execute")
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            print("Running TrafficMonitor#execute")
            (self.parentPID, self.pids) = PIDUtil.collectPIDs(appName: self.walletName)
            self.getIPs() // TODO - move to Util
            // TODO - Force Table repaint
        }
    }
    
    func parseOutput(_ output: String) -> [Connection] {
        var connections = [Connection]()
        
        let lines = output.components(separatedBy: "\n")
        for line in lines {
            let components = line.components(separatedBy: .whitespaces)
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
            connections.append(connection)
        }
        
        return connections
    }
    

    func getIPs() {
        for pid in pids {
            if let output = Command.runCommand("sudo lsof -i -a -p \(pid) -n") {
                let connections = parseOutput(output)
                print("------------Dump for \(pid):")
                for connection in connections {
                    // FIRST LOOP is the columns
                    print("Command: \(connection.command)")
                    print("PID: \(connection.pid)")
                    print("User: \(connection.user)")
                    print("File Descriptor: \(connection.fileDescriptor)")
                    print("Type: \(connection.type)")
                    print("Device: \(connection.device)")
                    print("Size/Offset: \(connection.sizeOffset)")
                    print("Node: \(connection.node)")
                    print("Name: \(connection.name)")
                    print("-------------------------")
                }
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
        textField.stringValue = "foo"
        textField.identifier = NSUserInterfaceItemIdentifier("TextCell")
        textField.isEditable = false
        textField.bezelStyle = .roundedBezel
        textField.isBezeled = false
        textField.alignment = .center
        textField.font = NSFont(name: FONT, size: TABLE_FONT)

        return textField
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ips.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return HEIGHT
    }
}
