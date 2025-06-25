//
//  ScuderiaModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct ScuderiaModel {
    var name: String
    var logo: String
    var points: Double
    var idFormula: UUID
    let id: UUID
    var country: String
    var victory: Int16
    var podium: Int16
    var details: String
    
    init(name: String, logo: String, points: Double, idFormula: UUID, country: String, victory: Int16, podium: Int16, details: String) {
        self.name = name
        self.logo = logo
        self.points = points
        self.idFormula = idFormula
        self.country = country
        self.victory = victory
        self.podium = podium
        self.details = details
        self.id = UUID()
    }
    
    init(id: UUID, name: String, logo: String, points: Double, idFormula: UUID, country: String, victory: Int16, podium: Int16, details: String) {
        self.id = id
        self.name = name
        self.logo = logo
        self.points = points
        self.idFormula = idFormula
        self.country = country
        self.victory = victory
        self.podium = podium
        self.details = details
    }
}
