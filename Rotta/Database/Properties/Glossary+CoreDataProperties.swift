//
//  Glossary+CoreDataProperties.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//
//

import Foundation
import CoreData


extension Glossary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Glossary> {
        return NSFetchRequest<Glossary>(entityName: "Glossary")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var details: String?
    @NSManaged public var image: String?


}

extension Glossary : Identifiable {

}
