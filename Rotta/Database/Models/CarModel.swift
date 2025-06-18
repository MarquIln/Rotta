//
//  CarModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct CarModel {
    var idComponents: [UUID]
    var idFormula: UUID
    var image: String?
    let id: UUID
    
    init(idComponents: [UUID], idFormula: UUID, image: String? = nil) {
        self.idComponents = idComponents
        self.idFormula = idFormula
        self.image = image
        self.id = UUID()
    }
    
    init(id: UUID, idComponents: [UUID], idFormula: UUID, image: String? = nil) {
        self.id = id
        self.idComponents = idComponents
        self.idFormula = idFormula
        self.image = image
    }
}
