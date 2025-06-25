//
//  Scuderia+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Scuderia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scuderia> {
        return NSFetchRequest<Scuderia>(entityName: "Scuderia")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idFormula: UUID?
    @NSManaged public var logo: String?
    @NSManaged public var name: String?
    @NSManaged public var points: Double
    @NSManaged public var country: String
    @NSManaged public var victory: Int16
    @NSManaged public var podium: Int16
    @NSManaged public var details: String
    
}

extension Scuderia : Identifiable {

}
