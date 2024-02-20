//
//  whirlpool.swift
//  Branta
//
//  Created by Keith Gardner on 1/11/24.
//

import Foundation

class Whirlpool: Wallet {
    
    override class func runtimeName() -> String {
        return "whirlpool-gui"
    }
    
    override class func name() -> String {
        return "whirlpool-gui.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "0.10.3": "703f47cfc62fa3a5ce33be852370d4126ac5602aaa6ec01d2e7d18073c5a6e01"
        ]
    }
    
    // Standard SHA 256 from manifest
    override class func installerHashes() -> [String:String] {
        return [
            "455f9f1d5ec5854f25edf47656d849db43d89a87c57ec73f750e67fc2d823808": "whirlpool-gui-0.10.4.dmg",
            "5324474e4f41d53f5cf139f8fa1011bffcb42f0d2bfa1e9f44c6247a5d98586f": "whirlpool-gui_Setup_0.10.4.exe",
            "a04c15fa5acf56c1ce18f2681cb4a83f973294f4cdf0478c9ba2e01d3c015140": "whirlpool-gui_0.10.4_amd64.snap",
            "21d4c8212e2e3142d88d9c7ed4f40d7e91653779119dabeb45007b35da26af7e": "whirlpool-gui_0.10.4_amd64.deb",
            "d714b469883927d3bbf69835e1280c792316fe0ab139398063f7ddfdb0e666a6": "whirlpool-gui-0.10.4.x86_64.rpm",
            "cdd03c92a299d7251fd2e272cec9b0f10c233ca5e0be28af14fcd6ffd9e2c838": "whirlpool-gui-0.10.4.AppImage"
        ]
    }
}
