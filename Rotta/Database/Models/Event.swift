//
//  Event.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewEvent(date: Date? = nil, startTime: Date? = nil, idFormula: UUID? = nil) {
        guard let context else { return }
        
        let newEvent = Event(context: context)
        newEvent.id = UUID()
        newEvent.date = date
        newEvent.startTime = startTime
        newEvent.idFormula = idFormula
        
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
    
    func getEventsByFormula(idFormula: UUID) -> [Event] {
        guard let context else { return [] }
        
        var result: [Event] = []
        
        do {
            let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idFormula == %@", idFormula as CVarArg)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }

    func deleteEvent(by id: UUID) {
        guard let context, let eventToDelete = getEvent(by: id) else { return }
        
        context.delete(eventToDelete)
        save()
    }
}
