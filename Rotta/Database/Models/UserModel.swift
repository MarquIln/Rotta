//
//  UserModel.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

struct User: Codable {
    let id: UUID
    var name: String
    var email: String
    var password: String
    var favoriteDriver: String?
    var currentFormula: String
    var dateCreated: Date
    
    init(id: UUID = UUID(), name: String, email: String, password: String, favoriteDriver: String? = nil, currentFormula: String = "Formula 2", dateCreated: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.favoriteDriver = favoriteDriver
        self.currentFormula = currentFormula
        self.dateCreated = dateCreated
    }
}
