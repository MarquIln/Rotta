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
    
    init(name: String, logo: String, points: Double, idFormula: UUID) {
        self.name = name
        self.logo = logo
        self.points = points
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, name: String, logo: String, points: Double, idFormula: UUID) {
        self.id = id
        self.name = name
        self.logo = logo
        self.points = points
        self.idFormula = idFormula
    }
}
