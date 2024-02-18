//
//  VersionComp.swift
//  Branta
//
//  Created by Keith Gardner on 2/18/24.
//

import Foundation


func compareVersions(_ version1: String, _ version2: String) -> ComparisonResult {
    let components1 = version1.split(separator: ".").compactMap { Int($0) }
    let components2 = version2.split(separator: ".").compactMap { Int($0) }

    for (comp1, comp2) in zip(components1, components2) {
        if comp1 < comp2 {
            return .orderedAscending
        } else if comp1 > comp2 {
            return .orderedDescending
        }
    }

    // If all components are equal so far, compare the number of components
    return components1.count < components2.count ? .orderedAscending : .orderedSame
}
