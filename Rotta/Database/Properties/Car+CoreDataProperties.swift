//
//  Car+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idComponents: [UUID]?
    @NSManaged public var idFormula: UUID?
    @NSManaged public var image: String?

}

extension Car : Identifiable {

}
