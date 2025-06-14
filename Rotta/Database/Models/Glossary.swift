//
//  Glossary.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewGlossaryTerm(name: String? = nil, details: String? = nil) {
        guard let context else { return }
        
        let newTerm = Glossary(context: context)
        newTerm.id = UUID()
        newTerm.name = name
        newTerm.details = details
        
        save()
    }
    
    func getAllGlossaryTerms() -> [Glossary] {
        guard let context else { return [] }
        
        var result: [Glossary] = []
        
        do {
            result = try context.fetch(Glossary.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getGlossaryTerm(by id: UUID) -> Glossary? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Glossary> = Glossary.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func searchGlossaryTerms(by name: String) -> [Glossary] {
        guard let context else { return [] }
        
        var result: [Glossary] = []
        
        do {
            let fetchRequest: NSFetchRequest<Glossary> = Glossary.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }
    
    func deleteGlossaryTerm(by id: UUID) {
        guard let context, let termToDelete = getGlossaryTerm(by: id) else { return }
        
        context.delete(termToDelete)
        save()
    }
}
