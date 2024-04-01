//
//  String.swift
//  Branta
//
//  Created by Keith Gardner on 3/28/24.
//

import Foundation

extension String {
    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
}
