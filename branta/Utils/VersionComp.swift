//
//  VersionComp.swift
//  Branta
//
//  Created by Keith Gardner on 2/18/24.
//

import Foundation

enum VersionComparisonError: Error {
    case BlankInput
}

func compareVersions(_ version1: String, _ version2: String) throws -> ComparisonResult {
    guard !version1.isEmpty && !version2.isEmpty else {
        throw VersionComparisonError.BlankInput
    }
    
    let components1 = version1.split(separator: ".").compactMap { Int($0) ?? 0 }
    let components2 = version2.split(separator: ".").compactMap { Int($0) ?? 0 }

    for (comp1, comp2) in zip(components1, components2) {
        if comp1 < comp2 {
            return .orderedAscending
        } else if comp1 > comp2 {
            return .orderedDescending
        }
    }

    if components1.count < components2.count {
        if components2.last == 0 {
            return .orderedSame
        }
        return .orderedAscending
    } else if components1.count > components2.count {
        if components1.last == 0 {
            return .orderedSame
        }
        return .orderedDescending
    } else {
        return .orderedSame
    }
}
