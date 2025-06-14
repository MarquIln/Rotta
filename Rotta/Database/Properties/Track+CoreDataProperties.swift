//
//  Track+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var distance: Double
    @NSManaged public var id: UUID?
    @NSManaged public var idFormula: [UUID]?
    @NSManaged public var location: String?
    @NSManaged public var name: String?

}

extension Track : Identifiable {

}
