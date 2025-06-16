//
//  DriverModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct DriverModel {
    var name: String
    var country: String
    var number: Int16
    var points: Double
    var scuderia: String
    var idFormula: UUID
    let id: UUID
    
    init(name: String, country: String, number: Int16, points: Double, scuderia: String, idFormula: UUID) {
        self.name = name
        self.country = country
        self.number = number
        self.points = points
        self.scuderia = scuderia
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, name: String, country: String, number: Int16, points: Double, scuderia: String, idFormula: UUID) {
        self.id = id
        self.name = name
        self.country = country
        self.number = number
        self.points = points
        self.scuderia = scuderia
        self.idFormula = idFormula
    }
}
