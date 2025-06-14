//
//  Track.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CoreData

extension Database {
    func addNewTrack(name: String? = nil, location: String? = nil, distance: Double = 0.0, idFormula: [UUID]? = nil) {
        guard let context else { return }
        
        let newTrack = Track(context: context)
        newTrack.id = UUID()
        newTrack.name = name
        newTrack.location = location
        newTrack.distance = distance
        newTrack.idFormula = idFormula
        
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
    
    func getTracksByFormula(idFormula: UUID) -> [Track] {
        guard let context else { return [] }
        
        var result: [Track] = []
        
        do {
            let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idFormula == %@", idFormula as CVarArg)
            result = try context.fetch(fetchRequest)
        } catch { print(error) }
        
        return result
    }
    
    func deleteTrack(by id: UUID) {
        guard let context, let trackToDelete = getTrack(by: id) else { return }
        
        context.delete(trackToDelete)
        save()
    }
}
