//
//  CarService.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import Foundation
import CloudKit

class ScuderiaService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .init(identifier: "iCloud.Rotta.CloudRotta")) {
        privateDatabase = container.publicCloudDatabase
    }

    func getAll() async -> [ScuderiaModel] {
        var scuderias: [ScuderiaModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Scuderia", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let scuderia = ScuderiaModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                        name: record["name"] as? String ?? "",
                        logo: record["logo"] as? String ?? "",
                        points: record["points"] as? Double ?? 0.0,
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
                    )
                    scuderias.append(scuderia)
                } catch {
                    print("Erro ao processar record Scuderia: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Scuderias: \(error.localizedDescription)")
        }
        return scuderias
    }

    func get(by id: UUID) async -> ScuderiaModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return ScuderiaModel(
                id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                name: record["name"] as? String ?? "",
                logo: record["logo"] as? String ?? "",
                points: record["points"] as? Double ?? 0.0,
                idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
            )
        } catch {
            print("Erro ao buscar Scuderia por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func getByFormula(idFormula: UUID) async -> [ScuderiaModel] {
        var scuderias: [ScuderiaModel] = []
        let predicate = NSPredicate(format: "idFormula == %@", idFormula.uuidString)
        let query = CKQuery(recordType: "Scuderia", predicate: predicate)
        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let scuderia = ScuderiaModel(
                        id: UUID(uuidString: record["id"] as? String ?? "") ?? UUID(),
                        name: record["name"] as? String ?? "",
                        logo: record["logo"] as? String ?? "",
                        points: record["points"] as? Double ?? 0.0,
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
                    )
                    scuderias.append(scuderia)
                } catch {
                    print("Erro ao processar record Scuderia: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Scuderias por Fórmula: \(error.localizedDescription)")
        }
        return scuderias
    }

    func add(name: String, logo: String, points: Double, idFormula: UUID) async {
        let uuid = UUID().uuidString
        let record = CKRecord(recordType: "Scuderia")
        record["id"] = uuid
        record["name"] = name
        record["logo"] = logo
        record["points"] = points
        record["idFormula"] = idFormula.uuidString
        do {
            let saved = try await privateDatabase.save(record)
            print("Scuderia salva com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Scuderia: \(error.localizedDescription)")
        }
    }
}
