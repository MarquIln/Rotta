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
        privateDatabase = container.privateCloudDatabase
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
                        date: record["date"] as? Date,
                        startTime: record["startTime"] as? Date,
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
                date: record["date"] as? Date,
                startTime: record["startTime"] as? Date,
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
                        date: record["date"] as? Date,
                        startTime: record["startTime"] as? Date,
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

    func getOnDate(_ date: Date) async -> [EventModel] {
        var events: [EventModel] = []
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        let query = CKQuery(recordType: "Event", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let event = EventModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(), 
                        date: record["date"] as? Date,
                        startTime: record["startTime"] as? Date,
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
                    )
                    events.append(event)
                } catch {
                    print("Erro ao processar record Event: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Events por data: \(error.localizedDescription)")
        }
        return events
    }

    func add(name: String, date: Date? = nil, startTime: Date? = nil, idFormula: UUID? = nil) async {
        let uuid = UUID().uuidString
        let record = CKRecord(recordType: "Event")
        record["id"] = uuid
        record["name"] = name
        if let date = date { record["date"] = date }
        if let startTime = startTime { record["startTime"] = startTime }
        if let idFormula = idFormula { record["idFormula"] = idFormula.uuidString }
        do {
            let saved = try await privateDatabase.save(record)
            print("Event salvo com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Event: \(error.localizedDescription)")
        }
    }
}
