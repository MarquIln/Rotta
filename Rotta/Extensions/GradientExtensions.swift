//
//  ViewExtensions.swift
//  Rotta
//
//  Created by Marcos on 05/07/25.
//

import UIKit

extension UIView {
    func addGradientCardInfos(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        gradientLayer.colors = colors ?? FormulaColorManager.shared.getCardInfosGradientColors()
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientCalendar(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? FormulaColorManager.shared.getCalendarGradientColors()
        gradientLayer.locations = [0.1, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientGlossary(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? FormulaColorManager.shared.getGlossaryGradientColors()
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientRankingView(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? FormulaColorManager.shared.getRankingGradientColors()
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func shake(duration: CFTimeInterval = 0.4, values: [CGFloat] = [-8, 8, -6, 6, -4, 4, 0]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = values
        layer.add(animation, forKey: "shake")
    }
    
    func addGradientDriverDetails(colors: [CGColor]? = nil) {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.colors = colors ?? FormulaColorManager.shared.getDriverDetailsGradientColors()
        gradientLayer.locations = [0.23, 0.4]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
