//
//  Database.swift
//  Rotta
//
//  Created by Marcos on 12/06/25.
//

import Foundation
import CoreData

class Database {
    static var shared = Database()
    
    var context: NSManagedObjectContext?
    
    private init() {}

    func save() {
        if let context, context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
