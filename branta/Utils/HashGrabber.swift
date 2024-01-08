//
//  HashGrabber.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Cocoa
import Foundation

class HashGrabber {
    static var appDelegate: AppDelegate?
    private static var hashes: [[String : [String : String]]] = [] // Cached for duration of Branta
    
    static func grab() -> [[String : [String : String]]] {
        if hashes != [] {
            return hashes
        }
        
        if false { // TODO - either we pull from public server, or we hardcode, or both.
            if isArm() {
                
            } else if isIntel() {
                
            }
        }
        else {
            if isArm() {
                hashes  = arm_HASHES
            } else if isIntel() {
                hashes  = x86_HASHES
            }
        }
        return hashes
    }
    
    private
    
    static func isArm() -> Bool {
#if arch(arm64)
        return true
#endif
        return false
    }
    
    static func isIntel() -> Bool {
#if arch(x86_64)
        return true
#endif
        return false
    }
    
    static let x86_HASHES = [
        // Note - Blockstream uses universal binary. These hashes are same across x86/arm
        // $ lipo -archs Blockstream\ Green
        // x86_64 arm64
        [ BLOCKSTREAM_GREEN:
            [
                "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
                "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
                "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
                "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
                "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
                "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
            ]
        ],
        [ SPARROW:
            [
                "1.8.1":"a35554c23d8e324f8e4226e15ad0b6d4a71da4f47c5a219b6b1b395472f57422",
                "1.8.0":"cd4ed0b38d94d6a9fb32effa0ee1700eed4cfc6306fd3c29cd87637b7a40519e",
                "1.7.9":"ba0c91af54e327a3acb9f3afc61aed19f2321c73e5a6a7733292727201d3a9c6",
                "1.7.8":"9ad69a2f0bc9d7089627398d8159532f9c27a13216c43610ec7a63097f5aeb1a",
                "1.7.7":"b9f6551a6ac55745bbb2989fae8f06d8b1e4938a06e5142d4927da51a6a87505",
                "1.7.6":"9a3df1b18e58ac6ba95eb50cfcb819672a69d68725f0e305df41d085d0adf56c",
                "1.7.5":"17ff3d80d5d0616a03a3beaa5417433d4b7d1a1b712807686bdd9bc8875a5348",
                "1.7.4":"efc69dfd54f2435b55c1f7195896085de58579bdc2acec4b11907835a4539fcd",
                "1.7.3":"ede392db8b50a58713e612fb8b0238320bbbd2053454fcc1a4a5bda5c88c592b",
                "1.7.2":"42bc031e1eb6e4a21b918014a9fe8505a48e2dbce5d54630c07df8d436ee78b2",
                "1.7.1":"c30fcb83b56f9f44dd040dd092efad942d089866418269d2411a48465ef7410c",
                "1.7.0":"4d772e2c42ae9b3a2fa32c81c86c0ab693a7b622463e98ed6e44b3b9171ab83f",
                "1.6.6":"b74fbea448d0d1b5d6cdaf827c49354974ca8c65e9809c96632b35bd3074a2db",
                "1.6.5":"e51308a58e0c079f2c76d4fa1ee775d253cdbcb5c8c938abc093b56229bda57f",
                "1.6.4":"e0e70d1160dcf2e8a0f4c9479f5160818337cac295da37fd53739e47031f1870",
                "1.6.3":"c9ebc422fed51111a211f645ab1496dc639fc80c75e18af70bdac91d9072594c",
                "1.6.2":"bdb27bedcf6396e4a007f64122155a2ea92804f88da16ee726b211a4c3d71d7e",
                "1.6.1":"766a8c08b6610b9d80a6538a3ec78d56c3a19cd59eb01efc5df94daf4c863dcb",
                "1.6.0":"44c4b5700a44ad20db7bd330262d8f945db05fdacd52f27a7020ea90fa106e92",
                "1.5.6":"cca2553f37f94df3f349696e73e4f67b06bcdf95f3a9f0ffd441b37b1d035579",
                "1.5.5":"d1d3caaf73368ca31ff1d15fd40e5439fd9dc2c7c95ab69d46f6e49e92d4e151"
            ]
        ],
        [ TREZOR:
            [
                "23.12.3": "8f576e56983a5fd45de75074861f5630254d23fe7c48a78621cc70b82715cb33",
                "23.12.2": "738afbb6682bd222992d8faf80f1e5a99953ffc44b3888217c794a9c2cea9f06",
                "23.12.1": "6300d1213e0f176d705a12e550e01656e6cf274949f6c7ef567923bbde61698b",
                "23.11.5": "2ece628962ef2ec793216aaa1347a543c61b929724646e6593853b275d38d30e",
                "23.11.4": "ed43fd602041c24e8d880f9ae0fb15c8ea5cee1299d7386122bdbf0f6f2c5a4d",
                "23.11.3": "16be0943a3c29c40673ba783fa55fcbdafd5f37639c5124d3d333a56790b5ba6",
                "23.11.2": "99b474516f9c41fffbda8abfb5aae2db4e5476783e06b45e9576daadae2f0907",
                "23.11.1": "d1adcfccfb2b630635dfc0d9483570914833f537d98b3479d1529ce35ad5f7b3",
                "23.10.1": "97f56112de9d93bb08fa1bd3db4340f5e30a51a2aaa7252c4cc1ea518b8470e9",
                "23.9.3": "ebeeb0fe4ce7e2daa4c24f91ed3e4389582cc20d1e72185450dbcbdfbdf42b03",
                "23.9.2": "f2899b73eb565810076a275729b053c7b375151102cf817066188bd6f8b47bc4",
                "23.9.1": "ea799e9b850b9ee7417e99c6b2d6363d04c28ed2bda381467d4f6f4dbe5f4831",
                "23.8.1": "03a34c5a49b468630446ec4a9933b83d8c89623a532aebcaead73e3d4e4edfb9",
                "23.7.2": "8ebabf473f02000a73d540fe6bcdbda47f7af0b24c424c0b06aa12efbdd74c55",
                "23.7.1": "1a5c58beb76a5bd7872213f5e1a8b86ececd8da3313de4ad197cfc8b490ff881",
                "23.6.1": "20ae1ef6ffbd0f1686463ddfb7f9d21694342d986c93060c9925646498284df6",
                "23.5.2": "1a5182762b1683b9d6c9323eb3d77d11b81dc8b9b2c37a7959f1e8dd2d95afb7",
                "23.5.1": "b7f743b3fb479a800b6ad024e792d8558b43e6292dc86a248a202eef0029488f",
                "23.4.2": "12c91245ee908e386990783765e41501f815d8ed6fecbd7e552aaa0bd6bdd421",
                "23.4.1": "542d69984a4d7a9c530749e823f77cca5f2a443e9d9722f0f0fcdf563e46d5f2",
                "23.3.2": "83fb65b59d2ebbdad05c164a924b9623d248eaae6518487d639f47ded5696489",
                "23.3.1": "5a147cf1a8478faf023ef5673a52d4c1ac14cf1d256810b21f5e646a0a5a91d8",
                "23.2.2": "5e48bb0d9537bcb0317b7602257b1940e2c69ac02c39c89dcf9faf4b0ce62557",
                "23.2.1": "9a9e88d86ef5550b9e06311578e8d00323152eef5edbb7c72b10a15ef5ee505a",
                "23.1.1": "516f165b72c0b0fb673a51500036e0d18de6fdab5c9f2734c954c58a8d5aa9a9",
            ]
        ],
        // Note - Ledger uses universal binary. These hashes are same across x86/arm
        // $ lipo -archs Ledger\ Live
        // x86_64 arm64
        [ LEDGER:
            [
                "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
                "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
                "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
                "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
                "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
                "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
            ]
        ]
    ]
    
    
    static let arm_HASHES = [
        [ BLOCKSTREAM_GREEN:
            [
                "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
                "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
                "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
                "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
                "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
                "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
            ]
        ],
        [ SPARROW:
            [
                "1.8.1":"c40b1533969a467f9ee7ce86c09d75ae0218127dc74c0554059df22ce5b23f87",
                "1.8.0":"50197b7d0952c211997f7f7633fd9e7ee427da1dfb0c443585eb413bad607c29",
                "1.7.9":"4804d0dd0f72dfcf02b05a657aba649c442141dcb3b9c027390f4a60e994cf9f",
            ]
        ],
        [ TREZOR:
            [
                "23.12.3": "cfc16e69b6bc1915e477a4d0b1f7726d95beb53468464f0093f48f33da809c6b",
                "23.12.2": "47dd2dd24dd54666f26794c8eac8b2a37656cd737a0c47738081adc6b5c630fd",
                "23.12.1": "62a4bc443f5f04a6dee0cc8039c725da73596bc6cd3aeeaf9721dfd5f6985022",
            ]
        ],
        [ LEDGER:
            [
                "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
                "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
                "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
                "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
                "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
                "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
            ]
        ]
    ]
}
