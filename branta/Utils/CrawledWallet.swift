//
//  CrawledWallet.swift
//  Branta
//
//  Created by Keith Gardner on 4/23/24.
//

struct CrawledWallet: Equatable {
    var cls: Wallet
    var fullWalletName: String
    var installPath: String
    var venderVersion: String
    var directorySHA256: String
    var brantaSignatureMatch: Bool
    var notFound: Bool
    var tooNew: Bool
    var tooOld: Bool
}
