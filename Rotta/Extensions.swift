//
//  Extensions.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 12/06/25.
//
import UIKit
extension UIView {
    func addGradientCardInfos(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "start") ?? .clear).withAlphaComponent(0.2).cgColor,
            (UIColor(named: "end") ?? .black).withAlphaComponent(1.0).cgColor
        ]
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientGlossary(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "start") ?? .clear).withAlphaComponent(0.8).cgColor,
            (UIColor(named: "end") ?? .black).withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

