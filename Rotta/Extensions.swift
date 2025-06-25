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
            (UIColor(named: "SprintFormula2") ?? .clear).withAlphaComponent(0.2).cgColor,
            (UIColor(named: "RaceFormula2") ?? .black).withAlphaComponent(1.0).cgColor
        ]
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientCalendar(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "CalendarGradientStart") ?? .clear).withAlphaComponent(1.0).cgColor,
            (UIColor(named: "CalendarGradientEnd") ?? .black).withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.1, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientGlossary(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "SprintFormula2") ?? .clear).withAlphaComponent(0.8).cgColor,
            (UIColor(named: "RaceFormula2") ?? .black).withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.4, 0.9]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientRankingView(colors: [CGColor]? = nil) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.0, y: 1.0)

        gradientLayer.colors = colors ?? [
            (UIColor(named: "RaceFormula2") ?? .clear).withAlphaComponent(0.7).cgColor,
            (UIColor(named: "SprintFormula2") ?? .black).withAlphaComponent(0.5).cgColor
        ]
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
        gradientLayer.colors = colors ?? [
            (UIColor(named: "SprintFormula2") ?? .clear).withAlphaComponent(0.0).cgColor,
            (UIColor(named: "RaceFormula2")   ?? .black).withAlphaComponent(1.0).cgColor
        ]
        gradientLayer.locations = [0.23, 0.4]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension String {
    func getCountryFlag() -> String {
        let country = self.lowercased()
        
        let flagMapping: [String: String] = [
            "brazil": "🇧🇷",
            "ireland": "🇮🇪",
            "united kingdom": "🇬🇧",
            "england": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
            "france": "🇫🇷",
            "spain": "🇪🇸",
            "italy": "🇮🇹",
            "germany": "🇩🇪",
            "netherlands": "🇳🇱",
            "monaco": "🇲🇨",
            "australia": "🇦🇺",
            "argentina": "🇦🇷",
            "colombia": "🇨🇴",
            "sweden": "🇸🇪",
            "india": "🇮🇳",
            "czech republic": "🇨🇿",
            "paraguay": "🇵🇾",
            "mexico": "🇲🇽",
            "japan": "🇯🇵",
            "belgium": "🇧🇪",
            "estonia": "🇪🇪",
            "bulgaria": "🇧🇬",
            "austria": "🇦🇹",
            "finland": "🇫🇮",
            "poland": "🇵🇱",
            "singapore": "🇸🇬",
            "norway": "🇳🇴",
            "denmark": "🇩🇰",
            "thailand": "🇹🇭",
            "united states": "🇺🇸",
            "peru": "🇵🇪",
            "united arab emirates": "🇦🇪",
            "bahrain": "🇧🇭",
            
            "brasil": "🇧🇷",
            "irlanda":  "🇮🇪",
            "reino unido": "🇬🇧",
            "frança": "🇫🇷",
            "espanha": "🇪🇸",
            "itália": "🇮🇹",
            "alemanha": "🇩🇪",
            "holanda": "🇳🇱",
            "mônaco": "🇲🇨",
            "austrália": "🇦🇺",
            "estados unidos": "🇺🇸",
            "colômbia": "🇨🇴",
            "suécia": "🇸🇪",
            "índia": "🇮🇳",
            "república tcheca": "🇨🇿",
            "paraguai": "🇵🇾",
            "méxico": "🇲🇽",
            "japão": "🇯🇵",
            "bélgica": "🇧🇪",
            "estônia": "🇪🇪",
            "bulgária": "🇧🇬",
            "áustria": "🇦🇹",
            "finlândia": "🇫🇮",
            "polônia": "🇵🇱",
            "singapura": "🇸🇬",
            "noruega": "🇳🇴",
            "dinamarca": "🇩🇰",
            "tailândia": "🇹🇭",
            "emirados árabes unidos": "🇦🇪",
            "UAE": "🇦🇪",
            "Arábia Saudita": "🇸🇦",
            "Azerbaijão": "🇦🇿",
            "Hungria": "🇭🇺",
            "UK": "🇬🇧",

            
        ]
        
        return flagMapping[country] ?? "🏁"
    }
}
