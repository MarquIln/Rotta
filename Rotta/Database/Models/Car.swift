//
//  Car.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewCar(idComponents: [UUID], idFormula: UUID, image: String? = nil) {
        guard let context else { return }
        
        let newCar = Car(context: context)
        newCar.id = UUID()
        newCar.idComponents = idComponents
        newCar.idFormula = idFormula
        newCar.image = image
        
        save()
    }
    
    func getAllCars() -> [Car] {
        guard let context else { return [] }
        
        var result: [Car] = []
        
        do {
            result = try context.fetch(Car.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getCar(by id: UUID) -> Car? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func getCarsByFormula(idFormula: UUID) -> [Car]? {
        guard let context else { return [] }
        
        var result: [Car] = []
        
        do {
            let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idFormula == %@", idFormula as CVarArg)
            result = try context.fetch(fetchRequest)
            return result
        } catch { print(error) }
        
        return []
    }

    func deleteCar(by id: UUID) {
        guard let context, let carToDelete = getCar(by: id) else { return }
        
        context.delete(carToDelete)
        save()
    }
}
