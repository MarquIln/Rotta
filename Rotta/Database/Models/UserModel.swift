//
//  UserModel.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit
import AuthenticationServices

struct User: Codable {
    let id: UUID
    var name: String
    var email: String
    var password: String?
    var favoriteDriver: String?
    var currentFormula: String?
    var dateCreated: Date
    var appleID: String?
    var profileImageData: Data?
    
    init(id: UUID = UUID(), name: String, email: String, password: String, favoriteDriver: String? = nil, currentFormula: String = "Formula 2", dateCreated: Date = Date(), appleID: String? = nil, profileImageData: Data? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.favoriteDriver = favoriteDriver
        self.currentFormula = currentFormula
        self.dateCreated = dateCreated
        self.appleID = appleID
        self.profileImageData = profileImageData
    }
    
    init(id: UUID = UUID(), credentials: ASAuthorizationAppleIDCredential) {
        self.id = id
        self.name = credentials.fullName?.givenName ?? "Apple User"
        self.email = credentials.email ?? ""
        self.dateCreated = Date()
        self.appleID = credentials.user
        self.password = nil
        self.favoriteDriver = nil
        self.currentFormula = "Formula 2"
        self.profileImageData = nil
    }
}
