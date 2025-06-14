//
//  Component.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewComponent(name: String? = nil, details: String? = nil, image: String? = nil) {
        guard let context else { return }
        
        let newComponent = Component(context: context)
        newComponent.id = UUID()
        newComponent.name = name
        newComponent.details = details
        newComponent.image = image
        
        save()
    }
    
    func getAllComponents() -> [Component] {
        guard let context else { return [] }
        
        var result: [Component] = []
        
        do {
            result = try context.fetch(Component.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getComponent(by id: UUID) -> Component? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Component> = Component.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func deleteComponent(by id: UUID) {
        guard let context, let componentToDelete = getComponent(by: id) else { return }
        
        context.delete(componentToDelete)
        save()
    }
}
