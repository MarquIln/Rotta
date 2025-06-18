//
//  GlossaryModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct GlossaryModel {
    var name: String?
    var details: String?
    let id: UUID
    
    init(name: String? = nil, details: String? = nil) {
        self.name = name
        self.details = details
        self.id = UUID()
    }
    
    init(id: UUID, name: String? = nil, details: String? = nil) {
        self.id = id
        self.name = name
        self.details = details
    }
}
