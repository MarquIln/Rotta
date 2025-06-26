//
//  CarService.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

class EventService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .init(identifier: "iCloud.Rotta.CloudRotta")) {
        privateDatabase = container.publicCloudDatabase
    }

    func getAll() async -> [EventModel] {
        var events: [EventModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Event", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let event = EventModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                        roundNumber: record["roundNumber"] as? Int16 ?? 0,
                        country: record["country"] as? String ?? "",
                        name: record["name"] as? String ?? "",
                        date: record["date"] as? Date,
                        startTime: record["startTime"] as? String ?? "",
                        endTime: record["endTime"] as? String ?? "",
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
                    )
                    events.append(event)
                } catch {
                    print("Erro ao processar record Event: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Events: \(error.localizedDescription)")
        }
        return events
    }

    func get(by id: UUID) async -> EventModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return EventModel(
                id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                roundNumber: record["roundNumber"] as? Int16 ?? 0,
                country: record["country"] as? String ?? "",
                name: record["name"] as? String ?? "",
                date: record["date"] as? Date,
                startTime: record["startTime"] as? String ?? "",
                endTime: record["endTime"] as? String ?? "",
                idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
            )
        } catch {
            print("Erro ao buscar Event por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func getByFormula(idFormula: UUID) async -> [EventModel] {
        var events: [EventModel] = []
        let predicate = NSPredicate(format: "idFormula == %@", idFormula.uuidString)
        let query = CKQuery(recordType: "Event", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let event = EventModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                        roundNumber: record["roundNumber"] as? Int16 ?? 0,
                        country: record["country"] as? String ?? "",
                        name: record["name"] as? String ?? "",
                        date: record["date"] as? Date,
                        startTime: record["startTime"] as? String ?? "",
                        endTime: record["endTime"] as? String ?? "",
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
                    )
                    events.append(event)
                } catch {
                    print("Erro ao processar record Event: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Events por Fórmula: \(error.localizedDescription)")
        }
        return events
    }

    func getEventsInRange(startDate: Date, endDate: Date) async -> [EventModel] {
        let allEvents = await getAll()
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let startOfPeriod = calendar.startOfDay(for: startDate)
        let endOfPeriod = calendar.startOfDay(for: endDate)
        
        let filtered = allEvents.filter { event in
            guard let eventDate = event.date else { return false }
            let eventDayStart = calendar.startOfDay(for: eventDate)
            return eventDayStart >= startOfPeriod && eventDayStart < endOfPeriod
        }
        
        return filtered
    }

    func getOnDate(_ date: Date) async -> [EventModel] {
        let allEvents = await getAll()
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let filtered = allEvents.filter {
            guard let eventDate = $0.date else { return false }
            return eventDate >= startOfDay && eventDate < endOfDay
        }

        return filtered
    }

    func add(roundNumber: Int16, country: String, name: String, date: Date? = nil, startTime: String, endTime: String, idFormula: UUID? = nil) async {
        let uuid = UUID().uuidString
        let record = CKRecord(recordType: "Event")
        record["id"] = uuid
        record["roundNumber"] = roundNumber
        record["country"] = country
        record["name"] = name
        if let date = date { record["date"] = date }
        record["startTime"] = startTime
        record["endTime"] = endTime
        if let idFormula = idFormula { record["idFormula"] = idFormula.uuidString }
        do {
            let saved = try await privateDatabase.save(record)
            print("Event salvo com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Event: \(error.localizedDescription)")
        }
    }
}
