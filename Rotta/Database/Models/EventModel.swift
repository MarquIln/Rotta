//
//  EventModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct EventModel {
    var date: Date?
    var startTime: Date?
    var idFormula: UUID?
    let id: UUID
    
    init(date: Date? = nil, startTime: Date? = nil, idFormula: UUID? = nil) {
        self.date = date
        self.startTime = startTime
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, date: Date? = nil, startTime: Date? = nil, idFormula: UUID? = nil) {
        self.id = id
        self.date = date
        self.startTime = startTime
        self.idFormula = idFormula
    }
}
