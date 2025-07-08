//
//  FormulaColorManager.swift
//  Rotta
//
//  Created by Marcos on 05/07/25.
//

import UIKit

protocol FormulaColorManagerDelegate: AnyObject {
    func formulaColorsDidChange()
}

private class Delegate {
    weak var delegate: FormulaColorManagerDelegate?
    
    init(_ delegate: FormulaColorManagerDelegate) {
        self.delegate = delegate
    }
}

class FormulaColorManager {
    static let shared = FormulaColorManager()
    
    private var currentFormula: FormulaType = .formula2
    private var delegates: [Delegate] = []
    
    private init() {
        currentFormula = Database.shared.getSelectedFormula()
    }
    
    func addDelegate(_ delegate: FormulaColorManagerDelegate) {
        delegates.append(Delegate(delegate))
        cleanupDelegates()
    }
    
    func removeDelegate(_ delegate: FormulaColorManagerDelegate) {
        delegates.removeAll { $0.delegate === delegate }
    }
    
    private func cleanupDelegates() {
        delegates.removeAll { $0.delegate == nil }
    }
    
    private func notifyDelegates() {
        cleanupDelegates()
        delegates.forEach { $0.delegate?.formulaColorsDidChange() }
    }
    
    var primaryColor: UIColor {
        switch currentFormula {
        case .formula2:
            return UIColor(named: "SprintFormula2") ?? .systemBlue
        case .formula3:
            return UIColor(named: "SprintFormula3") ?? .systemRed
        case .f1Academy:
            return UIColor(named: "SprintAcademy") ?? .systemPurple
        }
    }
    
    var raceColor: UIColor {
        switch currentFormula {
        case .formula2:
            return UIColor(named: "RaceFormula2") ?? .systemBlue
        case .formula3:
            return UIColor(named: "RaceFormula3") ?? .systemRed
        case .f1Academy:
            return UIColor(named: "RaceAcademy") ?? .systemPurple
        }
    }
    
    var qualiColor: UIColor {
        switch currentFormula {
        case .formula2:
            return UIColor(named: "QualiFormula2") ?? .systemBlue
        case .formula3:
            return UIColor(named: "QualiFormula3") ?? .systemRed
        case .f1Academy:
            return UIColor(named: "QualiAcademy") ?? .systemPurple
        }
    }
    
    var practiceColor: UIColor {
        switch currentFormula {
        case .formula2:
            return UIColor(named: "PracticeFormula2") ?? .systemBlue
        case .formula3:
            return UIColor(named: "PracticeFormula3") ?? .systemRed
        case .f1Academy:
            return UIColor(named: "PracticeAcademy") ?? .systemPurple
        }
    }
    
    var eventColor: UIColor {
        return .rottaYellow
    }
    
    var defaultTextColor: UIColor {
        return .rottaGray
    }
    
    func updateFormula(_ formula: FormulaType) {
        currentFormula = formula
        notifyDelegates()
    }
    
    func getCurrentFormula() -> FormulaType {
        return currentFormula
    }
    
    func getCardInfosGradientColors() -> [CGColor] {
        return [
            primaryColor.withAlphaComponent(0.2).cgColor,
            raceColor.withAlphaComponent(1.0).cgColor
        ]
    }
    
    func getGlossaryGradientColors() -> [CGColor] {
        return [
            primaryColor.withAlphaComponent(0.8).cgColor,
            raceColor.withAlphaComponent(0.7).cgColor
        ]
    }
    
    func getRankingGradientColors() -> [CGColor] {
        return [
            raceColor.withAlphaComponent(0.7).cgColor,
            primaryColor.withAlphaComponent(0.5).cgColor
        ]
    }
    
    func getDriverDetailsGradientColors() -> [CGColor] {
        return [
            primaryColor.withAlphaComponent(0.0).cgColor,
            raceColor.withAlphaComponent(1.0).cgColor
        ]
    }
    
    func getCalendarGradientColors() -> [CGColor] {
        return [
            primaryColor.withAlphaComponent(0.0).cgColor,
            primaryColor.withAlphaComponent(0.8).cgColor
        ]
    }
    
    func notifyFormulaChange(_ formula: FormulaType) {
        currentFormula = formula
        notifyDelegates()
    }
}

extension UIColor {
    static var formulaPrimary: UIColor {
        return FormulaColorManager.shared.primaryColor
    }
    static var formulaRace: UIColor {
        return FormulaColorManager.shared.raceColor
    }
    static var formulaQuali: UIColor {
        return FormulaColorManager.shared.qualiColor
    }
    static var formulaPractice: UIColor {
        return FormulaColorManager.shared.practiceColor
    }
}
