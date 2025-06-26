//
//  GlossaryModel.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

struct GlossaryModel {
    var title: String?
    var details: String?
    let id: UUID
    var subtitle: String?
    var image: String?
    
    init(title: String? = nil, details: String? = nil, subtitle: String? = nil, image: String? = nil) {
        self.title = title
        self.details = details
        self.id = UUID()
        self.subtitle = subtitle
        self.image = image
    }
    
    init(id: UUID, title: String? = nil, details: String? = nil, subtitle: String? = nil, image: String? = nil) {
        self.id = id
        self.title = title
        self.details = details
        self.subtitle = subtitle
        self.image = image
    }
}
