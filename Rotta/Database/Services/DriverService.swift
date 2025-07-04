//
//  CarService.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import CloudKit
import UIKit

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
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID(),
                        photo: record["photo"] as? String ?? "",
                        scuderiaLogo: record["scuderiaLogo"] as? String ?? "",
                        height: record["height"] as? String ?? "",
                        birthDate: record["birthDate"] as? Date ?? Date(),
                        championship: record["championship"] as? String ?? "",
                        details: record["details"] as? String ?? ""
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
    
    func getDriverWithScuderiaIcon(by id: UUID) async -> DriverModel? {
        do {
            let driverRecord = try await privateDatabase.record(for: CKRecord.ID(recordName: id.uuidString))
            
            guard let scuderiaIDString = driverRecord["idScuderia"] as? String,
                  let scuderiaID = UUID(uuidString: scuderiaIDString) else {
                return nil
            }

            let scuderiaRecord = try await privateDatabase.record(for: CKRecord.ID(recordName: scuderiaID.uuidString))
            
            let photoName = driverRecord["photo"] as? String ?? "defaultDriver"
            
            let scuderiaLogoName = scuderiaRecord["logo"] as? String ?? "defaultScuderia"

            return DriverModel(
                id: id,
                name: driverRecord["name"] as? String ?? "",
                country: driverRecord["country"] as? String ?? "",
                number: driverRecord["number"] as? Int16 ?? 0,
                points: driverRecord["points"] as? Int16 ?? 0,
                scuderia: driverRecord["scuderia"] as? String ?? "",
                photo: photoName,
                scuderiaLogo: scuderiaLogoName,
                height: driverRecord["height"] as? String ?? "",
                birthDate: driverRecord["birthDate"] as? Date ?? Date(),
                championship: driverRecord["championship"] as? String ?? "",
                details: driverRecord["details"] as? String ?? "",
                
            )

        } catch {
            print("❌ Erro ao buscar registros do CloudKit: \(error.localizedDescription)")
            return nil
        }
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
    
    func getDrivers(for formula: FormulaType) async -> [DriverModel] {
        let formulaService = FormulaService()
        let formulas = await formulaService.getAll()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getByFormula(idFormula: targetFormula.id)
    }

    func add(name: String, country: String, number: Int16, points: Int16, scuderia: String, idFormula: UUID, photo: String, scuderiaLogo: String, height: String, birthDate: Date, championship: String, details: String) async {
        let uuid = UUID().uuidString
        let record = CKRecord(recordType: "Driver")
        record["id"] = uuid
        record["name"] = name
        record["country"] = country
        record["number"] = number
        record["points"] = points
        record["scuderia"] = scuderia
        record["idFormula"] = idFormula.uuidString
        record["photo"] = photo
        record["scuderiaLogo"] = scuderiaLogo
        record["height"] = height
        record["birthDate"] = birthDate
        record["championship"] = championship
        record["details"] = details
        do {
            let saved = try await privateDatabase.save(record)
            print("Driver salvo com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Driver: \(error.localizedDescription)")
        }
    }
}
