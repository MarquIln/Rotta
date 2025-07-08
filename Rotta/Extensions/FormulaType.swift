//
//  FormulaType.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

enum FormulaType: String, CaseIterable, Codable {
    case f1Academy = "F1 Academy"
    case formula2 = "Formula 2"
    case formula3 = "Formula 3"

    var displayName: String {
        return self.rawValue
    }
}
