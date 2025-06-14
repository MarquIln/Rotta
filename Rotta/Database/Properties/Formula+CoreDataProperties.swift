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
    @NSManaged public var name: String?
    @NSManaged public var color: String?

}

extension Formula : Identifiable {

}
