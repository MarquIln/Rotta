import Foundation
import CloudKit

class ComponentService {
    private let privateDatabase: CKDatabase

    init(container: CKContainer = .default()) {
        privateDatabase = container.privateCloudDatabase
    }

    func getAll() async -> [ComponentModel] {
        var components: [ComponentModel] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Component", predicate: predicate)
        do {
            let resultados = try await privateDatabase.records(matching: query)
            for resultado in resultados.matchResults {
                do {
                    let record = try resultado.1.get()
                    let component = ComponentModel(
                        id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                        name: record["name"] as? String,
                        details: record["details"] as? String,
                        image: record["image"] as? String
                    )
                    components.append(component)
                } catch {
                    print("Erro ao processar record Component: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Components: \(error.localizedDescription)")
        }
        return components
    }

    func get(by id: UUID) async -> ComponentModel? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return ComponentModel(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String,
                details: record["details"] as? String,
                image: record["image"] as? String
            )
        } catch {
            print("Erro ao buscar Component por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func add(name: String? = nil, details: String? = nil, image: String? = nil) async {
        let record = CKRecord(recordType: "Component")
        if let name = name { record["name"] = name }
        if let details = details { record["details"] = details }
        if let image = image { record["image"] = image }
        do {
            let saved = try await privateDatabase.save(record)
            print("Component salva com sucesso: \(saved.recordID.recordName)")
        } catch {
            print("Erro ao salvar Component: \(error.localizedDescription)")
        }
    }
}
