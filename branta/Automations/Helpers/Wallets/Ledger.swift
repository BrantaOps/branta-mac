//
//  Ledger.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

import Foundation

/*
 Note - Ledger uses universal binary. These hashes are same across x86/arm
 
 $ lipo -archs Ledger\ Live
 x86_64 arm64
 */

class Ledger: Wallet {
    
    override class func runtimeName() -> String {
        return "Ledger Live"
    }
    
    override class func name() -> String {
        return "Ledger Live.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
            "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
            "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
            "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
            "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
            "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
            "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
            "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
            "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
            "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
            "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
        ]
    }
    
    // Standard SHA 512 from manifest (see https://www.ledger.com/ledger-live/lld-signatures)
    override class func installerHashes() -> [String:String] {
        return [
            // 2.75.0
            "2a4e77a8de337e8d5e7bd77888da963f9de3305be7d0c9ef384724445a173e800ef87d8fb6cca02352c280f30f79c9ba8e305cb47544e5bfdf692c092e1e7628": "ledger-live-desktop-2.75.0-linux-x86_64.AppImage",
            "2f8083905223e830302fbacedf24fe75c6cbc40420b21c9befee68dabad04aac5af9ddb572231fcb00675989ea31456a13c185ef60aaf1051bc43744d8e86915": "ledger-live-desktop-2.75.0-mac.dmg",
            "ee2c9c6c40f032e2410e291040deaa1c5fb6b422c7836c9fb6ad58bc3c189ced58185c149966f62e389132f5c63aed97daffeab4ddab682844fdaa34d63d72d1": "ledger-live-desktop-2.75.0-mac.zip",
            "11289b6f800395f9a7945bedc7bd061bfd6df9ba1f6bf5af20b0f97472785a77e38f9b28c2ed6dac2efba7bfcae1b2f794767192a489ab8a1735df212bfe0889": "ledger-live-desktop-2.75.0-win-x64.exe",
        
            // 2.73.1
            "849649f9f104d1a66e4705d0b83ab0c6edee553aad19b7ac8f10afecaf93b0f64e360abdad0ce2771c3cf290575ad266a63f2109cb998d3378ef6114abe6d153": "ledger-live-desktop-2.73.1-linux-x86_64.AppImage",
            "0ac6fe27ac26e818e156b805629b8faa79d389cceffff9fe0995a982fbd5509cb9d8313af8f77ee861b29258f68493ca7e18be7717acfb1c3d701b446d968b6d": "ledger-live-desktop-2.73.1-mac.dmg",
            "ca8b29835749ce11d658c564d6e8384cde7d52174c22b20d1bf9c57ae185324a2a9645fda827987840599030afd6dd7afaace63dc0da0d49568a14f0743b3c86": "ledger-live-desktop-2.73.1-mac.zip",
            "b203f25940e1a113d64dad7d3d61a5138d61b5663d56979013a3b15ad3624bd6e1abd43d112e4d880f09e2df47832e2ae58bd09a368d7a7c0155fc2b03be7e97": "ledger-live-desktop-2.73.1-win-x64.exe",

            // 2.73.0
            "a0581914c44ba7b8dfbc3cff3fa568a7eed9048a0b0f5212a0ac076b85929f4d62e2d92fe636d6bd83139b2333a711f6e373a5b7a42b4a65eb2a9a8f166a7846": "ledger-live-desktop-2.73.0-linux-x86_64.AppImage",
            "cdef29a985edb242f86d2f45b1be0a6054dddfdc9f3b54ab99242714c2c86dfbd7b089ab6b57099d068f205b119a6d456006856a8fbed09f0ccaf78bb4171ce1": "ledger-live-desktop-2.73.0-mac.dmg",
            "c4228605dad20997e2e7536ebfe7a7ed552778d10dfed47b6bcc0b114d3281d3713a86649f824c82b4640e0d15248bbe021f5aeb9d13faec67e359629c24c259": "ledger-live-desktop-2.73.0-mac.zip",
            "ab25a7d4c479e00b49df4683109cbdcec2d56c3635cb7535fbe69e888c8616b954401e115d803393892803f4b1265f3659d9a6775d1ee92c32bee0d08383b773": "ledger-live-desktop-2.73.0-win-x64.exe"            
        ]
    }
}
