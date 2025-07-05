//
//  UserPreferencesManager.swift
//  Rotta
//
//  Created by Marcos on 05/07/25.
//

import Foundation

class UserPreferencesManager {
    static let shared = UserPreferencesManager()
    
    private let userDefaults = UserDefaults.standard
    private let selectedFormulaKey = "selectedFormula"
    
    private init() {}

    func saveSelectedFormula(_ formula: FormulaType) {
        userDefaults.set(formula.rawValue, forKey: selectedFormulaKey)
        userDefaults.synchronize()
    }
    
    func getSelectedFormula() -> FormulaType {
        guard let formulaString = userDefaults.string(forKey: selectedFormulaKey),
              let formula = FormulaType(rawValue: formulaString) else {
            return .formula2
        }
        return formula
    }
    
    func hasSelectedFormula() -> Bool {
        return userDefaults.string(forKey: selectedFormulaKey) != nil
    }
    
    func clearSelectedFormula() {
        userDefaults.removeObject(forKey: selectedFormulaKey)
        userDefaults.synchronize()
    }
}
