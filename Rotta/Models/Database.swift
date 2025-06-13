//
//  Database.swift
//  Rotta
//
//  Created by Marcos on 12/06/25.
//

import Foundation
import CoreData

final class Database {
    
    static var shared = Database()
    
    var context: NSManagedObjectContext?
    
    private init() {}
    
    // MARK: - Car Methods
    func addNewCar(idComponents: [UUID], idFormula: [UUID], image: String? = nil) {
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
    
    func deleteCar(by id: UUID) {
        guard let context, let carToDelete = getCar(by: id) else { return }
        
        context.delete(carToDelete)
        save()
    }
    
    // MARK: - Component Methods
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
    
    // MARK: - Driver Methods
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
    
    func deleteDriver(by id: UUID) {
        guard let context, let driverToDelete = getDriver(by: id) else { return }
        
        context.delete(driverToDelete)
        save()
    }
    
    // MARK: - Event Methods
    func addNewEvent(date: Date? = nil, startTime: Date? = nil) {
        guard let context else { return }
        
        let newEvent = Event(context: context)
        newEvent.id = UUID()
        newEvent.date = date
        newEvent.startTime = startTime
        
        save()
    }
    
    func getAllEvents() -> [Event] {
        guard let context else { return [] }
        
        var result: [Event] = []
        
        do {
            result = try context.fetch(Event.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getEvent(by id: UUID) -> Event? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func getEvents(on date: Date) -> [Event] {
        guard let context else { return [] }
        
        var result: [Event] = []
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        do {
            let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }
    
    func deleteEvent(by id: UUID) {
        guard let context, let eventToDelete = getEvent(by: id) else { return }
        
        context.delete(eventToDelete)
        save()
    }
    
    // MARK: - Formula Methods
    func addNewFormula(name: String? = nil, idCars: [UUID] = [], idDrivers: [UUID] = [], idEvent: [UUID] = [], idRules: [UUID] = [], idScuderias: [UUID] = [], idTracks: [UUID] = []) {
        guard let context else { return }
        
        let newFormula = Formula(context: context)
        newFormula.id = UUID()
        newFormula.name = name
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
    
    // MARK: - Glossary Methods
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
    
    // MARK: - Rule Methods
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
    
    func deleteRule(by id: UUID) {
        guard let context, let ruleToDelete = getRule(by: id) else { return }
        
        context.delete(ruleToDelete)
        save()
    }
    
    // MARK: - Scuderia Methods
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
    
    // MARK: - Track Methods
    func addNewTrack(name: String? = nil, location: String? = nil, distance: Double = 0.0) {
        guard let context else { return }
        
        let newTrack = Track(context: context)
        newTrack.id = UUID()
        newTrack.name = name
        newTrack.location = location
        newTrack.distance = distance
        
        save()
    }
    
    func getAllTracks() -> [Track] {
        guard let context else { return [] }
        
        var result: [Track] = []
        
        do {
            result = try context.fetch(Track.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getTrack(by id: UUID) -> Track? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func deleteTrack(by id: UUID) {
        guard let context, let trackToDelete = getTrack(by: id) else { return }
        
        context.delete(trackToDelete)
        save()
    }
    
    // MARK: - Save Method
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
