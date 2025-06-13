//
//  Formula+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Formula {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Formula> {
        return NSFetchRequest<Formula>(entityName: "Formula")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idCars: [UUID]?
    @NSManaged public var idDrivers: [UUID]?
    @NSManaged public var idEvent: [UUID]?
    @NSManaged public var idRules: [UUID]?
    @NSManaged public var idScuderias: [UUID]?
    @NSManaged public var idTracks: [UUID]?
    @NSManaged public var name: String?

}

extension Formula : Identifiable {

}
