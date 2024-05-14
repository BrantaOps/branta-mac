//
//  BrantaConstants.swift
//  Branta
//
//  Created by Keith Gardner on 4/6/24.
//

import Foundation

// WALLETS
let TARGETS = [Sparrow.name()]
let APPS = [Sparrow.runtimeName()]
let USE_SHORT_VERSION_PATH: [String] = [] // // Blockstream used to use this.


// TYPEALIAS
typealias RuntimeHashType       = [String: [String:String]]
typealias InstallerHashType     = [String:String]

let API_CADENCE = 30.0

// URLS

let FETCH_URL = "https://api.github.com/repos/brantaops/branta-mac/releases/latest"

// UI CONSTANTS
let HEIGHT      = 30.0
let TABLE_FONT  = 20.0


let TEST_FOR_SUDO = "echo 'test for sudo.'"

// NOTIFICATIONS

let NOTIFY_FOR_BTC_ADDRESS          = "notifyForBTCAddress"
let NOTIFY_FOR_SEED                 = "notifyForSeed"
let NOTIFY_FOR_XPUB                 = "notifyForXPub"
let NOTIFY_FOR_XPRV                 = "notifyForXPrv"
let NOTIFY_FOR_NPUB                 = "notifyForNPub"
let NOTIFY_FOR_NSEC                 = "notifyForNSec"
let NOTIFY_UPON_LAUNCH              = "notifyUponLaunch"
let NOTIFY_UPON_STATUS_CHANGE       = "notifyUponStatusChange"

let SCAN_CADENCE                    = "scanCadence"
let SCAN_CADENCE_WORDING            = "scanCadenceWording"

let DEFAULT_SCAN_CADENCE            = 30.0
let DEFAULT_SCAN_CADENCE_WORDING    = "30 Seconds"

let SHOW_IN_DOCK                    = "showInDock"

let XPUBS                           = "xpubs"


let PREFS_KEY = "Branta_Prefs"


let CLIPBOARD_INTERVAL  = 1.0 // Seconds

let SEED_WORDS_MIN = 10
let SEED_WORDS_MAX = 26

let WRONG_PASSWORD          = "Incorrect Password"
let CADENCE_OPTIONS: [(String, Int)] = [
    ("1 Second", 1),
    ("5 Seconds", 5),
    ("10 Seconds", 10),
    ("30 Seconds", 30),
    ("60 Seconds", 60),
    ("5 Minutes", 300),
    ("10 Minutes", 600),
    ("30 Minutes", 1800)
]

let FONT                    = "Avenir"
let GOLD                    = "#B1914A"
let RED                     = "#944545"
let GRAY                    = "#333130"
let BLACK                   = "#000000"
let ACTIVE                  = "Status: Active ✓"
let KEYCODE_COMMA           = 43
