//
//  TrackModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct TrackModel {
    var name: String?
    var location: String?
    var distance: Double
    var idFormula: [UUID]?
    let id: UUID
    
    init(name: String? = nil, location: String? = nil, distance: Double = 0.0, idFormula: [UUID]? = nil) {
        self.name = name
        self.location = location
        self.distance = distance
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, name: String? = nil, location: String? = nil, distance: Double = 0.0, idFormula: [UUID]? = nil) {
        self.id = id
        self.name = name
        self.location = location
        self.distance = distance
        self.idFormula = idFormula
    }
}
