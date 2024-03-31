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
    
    var tableView: NSTableView

    
    var parentPID: Int = -1
    var pids: Array<Int> = []
    var connections: Array<Connection> = []
    var walletName:String?
    weak var observer: DataFeedObserver?

    
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
        Timer.scheduledTimer(withTimeInterval: CADENCE, repeats: true) { _ in
//            print("TrafficMonitor#execute: pids=\(self.pids), connections=\(self.connections)")
            
            
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
//        print("Running TrafficMonitor#parseOutput on output: \(output)")

//        var connections = [Connection]()
        
        let lines = output.components(separatedBy: "\n")
        
        for line in lines {
//            print("Running TrafficMonitor#parseOutput on line: \(line)")

            let processedLine = line.removeExtraSpaces()
            let components = processedLine.components(separatedBy: .whitespaces)
//            print("Running TrafficMonitor#parseOutput on components: \(components)")

            // Skip table heading
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
                
                print("Running TrafficMonitor#parseOutput appending: \(connection)")
                if !(connections.contains(where: {
//                    $0.command == connection.command &&
//                    $0.pid == connection.pid &&
//                    $0.user == connection.user &&
//                    $0.fileDescriptor == connection.fileDescriptor &&
//                    $0.type == connection.type &&
//                    $0.device == connection.device &&
//                    $0.sizeOffset == connection.sizeOffset &&
//                    $0.node == connection.node &&
                    $0.name == connection.name
                 })) {
                    connections.append(connection)
                }
                
            }

        }
        
//        return connections
    }
    

    func getConnections() {
        for pid in pids {
//            print("Running TrafficMonitor#getIPs on \(pids)")
            if let output = Command.runCommand("sudo lsof -i -a -p \(pid) -n") {
                parseOutput(output)
            }
        }
    }
}

extension TrafficMonitor: NSTableViewDelegate, NSTableViewDataSource {

    
    //
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
            textField.stringValue = connections[row].name
        } else {
            print("columnNumber == else")
        }
        return textField
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        print("returning numberOfRows \(connections.count), ")
        return connections.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return HEIGHT
    }
}
