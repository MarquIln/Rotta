//
//  Scuderia.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewScuderia(name: String? = nil, logo: String? = nil, points: Double = 0.0, idFormula: UUID? = nil) {
        guard let context else { return }
        
        let newScuderia = Scuderia(context: context)
        newScuderia.id = UUID()
        newScuderia.name = name
        newScuderia.logo = logo
        newScuderia.points = points
        newScuderia.idFormula = idFormula
        
        save()
    }
    
    func getAllScuderias() -> [Scuderia] {
        guard let context else { return [] }
        
        var result: [Scuderia] = []
        
        do {
            result = try context.fetch(Scuderia.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getScuderia(by id: UUID) -> Scuderia? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Scuderia> = Scuderia.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func deleteScuderia(by id: UUID) {
        guard let context, let scuderiaToDelete = getScuderia(by: id) else { return }
        
        context.delete(scuderiaToDelete)
        save()
    }
}
