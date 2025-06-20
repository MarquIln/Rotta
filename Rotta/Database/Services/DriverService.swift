//
//  CarService.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

class DriverService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .init(identifier: "iCloud.Rotta.CloudRotta")) {
        privateDatabase = container.publicCloudDatabase
    }

    func getAll() async -> [DriverModel] {
        var drivers: [DriverModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Driver", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let driver = DriverModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                        name: record["name"] as? String ?? "",
                        country: record["country"] as? String ?? "",
                        number: record["number"] as? Int16 ?? 0,
                        points: record["points"] as? Int16 ?? 0,
                        scuderia: record["scuderia"] as? String ?? "",
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
                    )
                    drivers.append(driver)
                } catch {
                    print("Erro ao processar record Driver: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Drivers: \(error.localizedDescription)")
        }
        return drivers
    }
    
    func getByFormula(idFormula: UUID) async -> [DriverModel] {
        var drivers = await getAll()
        for driver in drivers {
            if driver.idFormula != idFormula {
                drivers.removeAll { $0.id == driver.id }
            }
        }
        
        return drivers
    }

    func getByScuderia(scuderiaId: UUID) async -> [DriverModel] {
        var drivers = await getAll()
        for driver in drivers {
            if driver.scuderia != scuderiaId.uuidString {
                drivers.removeAll { $0.id == driver.id }
            }
        }
        
        return drivers
    }

    func add(name: String, country: String, number: Int16, points: Double, scuderia: UUID, idFormula: UUID) async {
        let uuid = UUID().uuidString
        let record = CKRecord(recordType: "Driver")
        record["id"] = uuid
        record["name"] = name
        record["country"] = country
        record["number"] = number
        record["points"] = points
        record["scuderia"] = scuderia.uuidString
        record["idFormula"] = idFormula.uuidString
        do {
            let saved = try await privateDatabase.save(record)
            print("Driver salvo com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Driver: \(error.localizedDescription)")
        }
    }
}
