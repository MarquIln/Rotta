//
//  RuleModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct RuleModel {
    var name: String?
    var details: String?
    var idFormula: UUID?
    let id: UUID
    
    init(name: String? = nil, details: String? = nil, idFormula: UUID? = nil) {
        self.name = name
        self.details = details
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, name: String? = nil, details: String? = nil, idFormula: UUID? = nil) {
        self.id = id
        self.name = name
        self.details = details
        self.idFormula = idFormula
    }
}
