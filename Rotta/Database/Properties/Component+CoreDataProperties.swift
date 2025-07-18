//
//  Component+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Component {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Component> {
        return NSFetchRequest<Component>(entityName: "Component")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var property: String?
    @NSManaged public var image: String?
    @NSManaged public var id: UUID?
}

extension Component : Identifiable {

}
