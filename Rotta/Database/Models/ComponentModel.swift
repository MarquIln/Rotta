//
//  ComponentModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct ComponentModel {
    var name: String?
    var details: String?
    var image: String?
    let id: UUID
    
    init(name: String? = nil, details: String? = nil, image: String? = nil) {
        self.name = name
        self.details = details
        self.image = image
        self.id = UUID()
    }
    
    init(id: UUID, name: String? = nil, details: String? = nil, image: String? = nil) {
        self.id = id
        self.name = name
        self.details = details
        self.image = image
    }
}
