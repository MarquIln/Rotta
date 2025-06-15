import Foundation
import CloudKit

class RuleService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .default()) {
        privateDatabase = container.privateCloudDatabase
    }

    func getAll() async -> [RuleModel] {
        var rules: [RuleModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Rule", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let rule = RuleModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String,
                        details: record["details"] as? String,
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
                    )
                    rules.append(rule)
                } catch {
                    print("Erro ao processar record Rule: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Rules: \(error.localizedDescription)")
        }
        return rules
    }

    func get(by id: UUID) async -> RuleModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return RuleModel(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String,
                details: record["details"] as? String,
                idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
            )
        } catch {
            print("Erro ao buscar Rule por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func getByFormula(idFormula: UUID) async -> [RuleModel] {
        var rules: [RuleModel] = []
        let predicate = NSPredicate(format: "idFormula == %@", idFormula.uuidString)
        let query = CKQuery(recordType: "Rule", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let rule = RuleModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String,
                        details: record["details"] as? String,
                        idFormula: UUID(uuidString: record["idFormula"] as? String ?? "")
                    )
                    rules.append(rule)
                } catch {
                    print("Erro ao processar record Rule: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Rules por Fórmula: \(error.localizedDescription)")
        }
        return rules
    }

    func add(name: String? = nil, details: String? = nil, idFormula: UUID? = nil) async {
        let record = CKRecord(recordType: "Rule")
        if let name = name { record["name"] = name }
        if let details = details { record["details"] = details }
        if let idFormula = idFormula { record["idFormula"] = idFormula.uuidString }
        do {
            let saved = try await privateDatabase.save(record)
            print("Rule salva com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Rule: \(error.localizedDescription)")
        }
    }
}
