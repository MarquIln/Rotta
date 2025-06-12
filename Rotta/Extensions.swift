//
//  Extensions.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 12/06/25.
//
import UIKit
extension UIView {
    func addGradient(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "start") ?? .clear).withAlphaComponent(0.3).cgColor,
            (UIColor(named: "end") ?? .black).withAlphaComponent(1.0).cgColor
        ]
        gradientLayer.locations = [0.5, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

