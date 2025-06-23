//
//  DriverModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit
import UIKit

struct DriverModel {
    var name: String
    var country: String?
    var number: Int16?
    var points: Int16
    var scuderia: String?
    var idFormula: UUID?
    var photo: String?
    var scuderiaLogo: String?
    let id: UUID
    
    init(name: String, country: String, number: Int16, points: Int16, scuderia: String) {
        self.name = name
        self.country = country
        self.number = number
        self.points = points
        self.scuderia = scuderia
        self.id = UUID()
    }
    
    init(id: UUID, name: String, points: Int16, photo: String, scuderiaLogo: String) {
        self.id = id
        self.name = name
        self.points = points
        self.photo = photo
        self.scuderiaLogo = scuderiaLogo
    }
    
    init(id: UUID, name: String, country: String, number: Int16, points: Int16, scuderia: String, idFormula: UUID, photo: String, scuderiaLogo: String) {
        self.id = id
        self.name = name
        self.country = country
        self.number = number
        self.points = points
        self.scuderia = scuderia
        self.idFormula = idFormula
        self.photo = photo
        self.scuderiaLogo = scuderiaLogo
    }
}
