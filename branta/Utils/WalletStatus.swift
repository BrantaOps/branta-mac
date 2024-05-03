//
//  WalletStatus.swift
//  Branta
//
//  Created by Keith Gardner on 5/3/24.
//

import Foundation

enum WalletStatus {
    case TooOld
    case TooNew
    case UnknownVersion
    case SignatureMatch
    case SignatureMismatch
}
