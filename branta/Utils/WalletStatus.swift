//
//  WalletStatus.swift
//  Branta
//
//  Created by Keith Gardner on 5/22/24.
//

import Foundation

enum WalletStatus {
    case Verified
    case NotVerified
    case VersionTooNew
    case VersionTooOld
    case VersionNotSupported
    case NotFound
    case Installing
    case BrantaError
}
