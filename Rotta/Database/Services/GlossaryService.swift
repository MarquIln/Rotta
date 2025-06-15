import Foundation
import CloudKit

class GlossaryService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .default()) {
        privateDatabase = container.privateCloudDatabase
    }

    func getAll() async -> [GlossaryModel] {
        var terms: [GlossaryModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Glossary", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let term = GlossaryModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String ?? "",
                        details: record["details"] as? String ?? ""
                    )
                    terms.append(term)
                } catch {
                    print("Erro ao processar record Glossary: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Glossary terms: \(error.localizedDescription)")
        }
        return terms
    }

    func get(by id: UUID) async -> GlossaryModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return GlossaryModel(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String ?? "",
                details: record["details"] as? String ?? ""
            )
        } catch {
            print("Erro ao buscar Glossary por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func add(name: String? = nil, details: String? = nil) async {
        let record = CKRecord(recordType: "Glossary")
        if let name = name { record["name"] = name }
        if let details = details { record["details"] = details }
        do {
            let saved = try await privateDatabase.save(record)
            print("Glossary term salvo com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Glossary term: \(error.localizedDescription)")
        }
    }
}
