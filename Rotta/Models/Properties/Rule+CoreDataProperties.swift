//
//  Rule+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Rule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rule> {
        return NSFetchRequest<Rule>(entityName: "Rule")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: UUID?
    @NSManaged public var idFormula: UUID?
    @NSManaged public var name: String?

}

extension Rule : Identifiable {

}
