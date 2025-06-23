//
//  Driver+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Driver {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Driver> {
        return NSFetchRequest<Driver>(entityName: "Driver")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: UUID?
    @NSManaged public var idFormula: UUID?
    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var points: Int16
    @NSManaged public var scuderia: String?
    @NSManaged public var photo: String?
    @NSManaged public var scuderiaLogo: String?
    @NSManaged public var height: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var championship: String?
    @NSManaged public var details: String?

}

extension Driver : Identifiable {

}
