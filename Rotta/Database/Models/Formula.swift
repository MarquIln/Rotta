//
//  Formula.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewFormula(name: String? = nil, color: String? = nil, idCars: [UUID] = [], idDrivers: [UUID] = [], idEvent: [UUID] = [], idRules: [UUID] = [], idScuderias: [UUID] = [], idTracks: [UUID] = []) {
        guard let context else { return }
        
        let newFormula = Formula(context: context)
        newFormula.id = UUID()
        newFormula.name = name
        newFormula.color = color
        newFormula.idCars = idCars
        newFormula.idDrivers = idDrivers
        newFormula.idEvent = idEvent
        newFormula.idRules = idRules
        newFormula.idScuderias = idScuderias
        newFormula.idTracks = idTracks
        
        save()
    }
    
    func getAllFormulas() -> [Formula] {
        guard let context else { return [] }
        
        var result: [Formula] = []
        
        do {
            result = try context.fetch(Formula.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getFormula(by id: UUID) -> Formula? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Formula> = Formula.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func deleteFormula(by id: UUID) {
        guard let context, let formulaToDelete = getFormula(by: id) else { return }
        
        context.delete(formulaToDelete)
        save()
    }
}
