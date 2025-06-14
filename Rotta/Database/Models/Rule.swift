//
//  Rule.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewRule(name: String? = nil, details: String? = nil, idFormula: UUID? = nil) {
        guard let context else { return }
        
        let newRule = Rule(context: context)
        newRule.id = UUID()
        newRule.name = name
        newRule.details = details
        newRule.idFormula = idFormula
        
        save()
    }
    
    func getAllRules() -> [Rule] {
        guard let context else { return [] }
        
        var result: [Rule] = []
        
        do {
            result = try context.fetch(Rule.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getRule(by id: UUID) -> Rule? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Rule> = Rule.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func getRulesByFormula(idFormula: UUID) -> [Rule] {
        guard let context else { return [] }
        
        var result: [Rule] = []
        
        do {
            let fetchRequest: NSFetchRequest<Rule> = Rule.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idFormula == %@", idFormula as CVarArg)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }

    func deleteRule(by id: UUID) {
        guard let context, let ruleToDelete = getRule(by: id) else { return }
        
        context.delete(ruleToDelete)
        save()
    }
}
