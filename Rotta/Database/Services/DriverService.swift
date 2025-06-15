import Foundation
import CloudKit

class DriverService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .default()) {
        self.privateDatabase = container.privateCloudDatabase
    }

    func getAll() async -> [DriverModel] {
        var drivers: [DriverModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Driver", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let driver = DriverModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String ?? "",
                        country: record["country"] as? String ?? "",
                        number: record["number"] as? Int16 ?? 0,
                        points: record["points"] as? Double ?? 0.0,
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

    func get(by id: UUID) async -> DriverModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return DriverModel(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String ?? "",
                country: record["country"] as? String ?? "",
                number: record["number"] as? Int16 ?? 0,
                points: record["points"] as? Double ?? 0.0,
                scuderia: record["scuderia"] as? String ?? "",
                idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
            )
        } catch {
            print("Erro ao buscar Driver por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func getByFormula(idFormula: UUID) async -> [DriverModel] {
        var drivers: [DriverModel] = []
        let predicate = NSPredicate(format: "idFormula == %@", idFormula.uuidString)
        let query = CKQuery(recordType: "Driver", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let driver = DriverModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String ?? "",
                        country: record["country"] as? String ?? "",
                        number: record["number"] as? Int16 ?? 0,
                        points: record["points"] as? Double ?? 0.0,
                        scuderia: record["scuderia"] as? String ?? "",
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
                    )
                    drivers.append(driver)
                } catch {
                    print("Erro ao processar record Driver: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Drivers por Fórmula: \(error.localizedDescription)")
        }
        return drivers
    }

    func getByScuderia(scuderiaId: UUID) async -> [DriverModel] {
        var drivers: [DriverModel] = []
        let predicate = NSPredicate(format: "scuderiaId == %@", scuderiaId.uuidString)
        let query = CKQuery(recordType: "Driver", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let driver = DriverModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String ?? "",
                        country: record["country"] as? String ?? "",
                        number: record["number"] as? Int16 ?? 0,
                        points: record["points"] as? Double ?? 0.0,
                        scuderia: record["scuderia"] as? String ?? "",
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "") ?? UUID()
                    )
                    drivers.append(driver)
                } catch {
                    print("Erro ao processar record Driver: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Drivers por Scuderia: \(error.localizedDescription)")
        }
        return drivers
    }

    func add(name: String, country: String, number: Int16, points: Double, scuderia: UUID, idFormula: UUID) async {
        let record = CKRecord(recordType: "Driver")
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
