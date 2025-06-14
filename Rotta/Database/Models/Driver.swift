//
//  Driver.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewDriver(name: String? = nil, country: String? = nil, number: Int16 = 0, points: Double = 0.0, scuderia: UUID? = nil, idFormula: UUID? = nil) {
        guard let context else { return }
        
        let newDriver = Driver(context: context)
        newDriver.id = UUID()
        newDriver.name = name
        newDriver.country = country
        newDriver.number = number
        newDriver.points = points
        newDriver.scuderia = scuderia
        newDriver.idFormula = idFormula
        
        save()
    }
    
    func getAllDrivers() -> [Driver] {
        guard let context else { return [] }
        
        var result: [Driver] = []
        
        do {
            result = try context.fetch(Driver.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getDriver(by id: UUID) -> Driver? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Driver> = Driver.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func getDrivers(by scuderiaId: UUID) -> [Driver] {
        guard let context else { return [] }
        
        var result: [Driver] = []
        
        do {
            let fetchRequest: NSFetchRequest<Driver> = Driver.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "scuderia == %@", scuderiaId as CVarArg)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }
    
    func getDriversByFormula(idFormula: UUID) -> [Driver] {
        guard let context else { return [] }
        
        var result: [Driver] = []
        
        do {
            let fetchRequest: NSFetchRequest<Driver> = Driver.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idFormula == %@", idFormula as CVarArg)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }

    func deleteDriver(by id: UUID) {
        guard let context, let driverToDelete = getDriver(by: id) else { return }
        
        context.delete(driverToDelete)
        save()
    }
}
