//
//  Event+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var roundNumber: Int16
    @NSManaged public var country: String
    @NSManaged public var name: String
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var idFormula: UUID?
    @NSManaged public var startTime: String
    @NSManaged public var endTime: String


}

extension Event : Identifiable {

}
