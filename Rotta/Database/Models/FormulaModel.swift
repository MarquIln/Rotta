//
//  FormulaModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct FormulaModel {
    var name: String
    var color: String
    let id: UUID
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
        self.id = UUID()
    }
    
    init(id: UUID, name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}
