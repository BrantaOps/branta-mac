//
//  BrantaConstants.swift
//  Branta
//
//  Created by Keith Gardner on 4/6/24.
//

import Foundation

let HEIGHT      = 30.0
let TABLE_FONT  = 17.0

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
let ACTIVE                  = "Status: Active ✓"
let KEYCODE_COMMA           = 43

let APPS = [
    Sparrow.runtimeName(),
    Trezor.runtimeName(),
    Ledger.runtimeName(),
    BlockstreamGreen.runtimeName(),
    Wasabi.runtimeName(),
    Whirlpool.runtimeName()
]
