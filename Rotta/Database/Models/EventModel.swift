//
//  EventModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct EventModel {
    var roundNumber: Int16
    var country: String
    var name: String
    var date: Date?
    var startTime: String
    var endTime: String
    var idFormula: UUID?
    let id: UUID
    
    init(roundNumber: Int16, country: String, name: String, date: Date? = nil, startTime: String, endTime: String, idFormula: UUID? = nil) {
        self.roundNumber = roundNumber
        self.country = country
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.idFormula = idFormula
        self.id = UUID()
    }
    
    init(id: UUID, roundNumber: Int16, country: String, name: String, date: Date? = nil, startTime: String, endTime: String, idFormula: UUID? = nil) {
        self.id = id
        self.roundNumber = roundNumber
        self.country = country
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.idFormula = idFormula
    }
}
