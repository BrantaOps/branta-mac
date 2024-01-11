//
//  Trezor.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

import Foundation

class Trezor: Wallet {
    override class func name() -> String {
        return "Trezor Suite.app"
    }
    
    override class func x86() -> [String:String] {
        return [
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
    }
    
    override class func arm() -> [String:String] {
        return [
            "23.12.3": "cfc16e69b6bc1915e477a4d0b1f7726d95beb53468464f0093f48f33da809c6b",
            "23.12.2": "47dd2dd24dd54666f26794c8eac8b2a37656cd737a0c47738081adc6b5c630fd",
            "23.12.1": "62a4bc443f5f04a6dee0cc8039c725da73596bc6cd3aeeaf9721dfd5f6985022",
        ]
    }
}
