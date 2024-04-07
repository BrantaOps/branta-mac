//
//  ConnectionTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 3/30/24.
//

import Foundation
import XCTest
@testable import Branta

class ConnectionTests: XCTestCase {

    func testConnectionInitialization() {
        let connection = Connection(command: "ssh", pid: "1234", user: "user", fileDescriptor: "fd123", type: "tcp", device: "eth0", sizeOffset: "1024", node: "/dev/null", name: "TestConnection")
        
        XCTAssertEqual(connection.command, "ssh")
        XCTAssertEqual(connection.pid, "1234")
        XCTAssertEqual(connection.user, "user")
        XCTAssertEqual(connection.fileDescriptor, "fd123")
        XCTAssertEqual(connection.type, "tcp")
        XCTAssertEqual(connection.device, "eth0")
        XCTAssertEqual(connection.sizeOffset, "1024")
        XCTAssertEqual(connection.node, "/dev/null")
        XCTAssertEqual(connection.name, "TestConnection")
    }

    func testConnectionEquality() {
        let connection1 = Connection(command: "ssh", pid: "1234", user: "user", fileDescriptor: "fd123", type: "tcp", device: "eth0", sizeOffset: "1024", node: "/dev/null", name: "TestConnection")
        let connection2 = Connection(command: "ssh", pid: "1234", user: "user", fileDescriptor: "fd123", type: "tcp", device: "eth0", sizeOffset: "1024", node: "/dev/null", name: "TestConnection")
        let connection3 = Connection(command: "ssh", pid: "5678", user: "user", fileDescriptor: "fd567", type: "udp", device: "eth1", sizeOffset: "2048", node: "/dev/random", name: "AnotherConnection")
        
        XCTAssertEqual(connection1, connection2)
        XCTAssertNotEqual(connection1, connection3)
    }
}
