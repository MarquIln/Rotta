//
//  UserService.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit
import CloudKit
import CryptoKit

class UserService {
    static let shared = UserService()
    private let loggedUserKey = "loggedUser"

    private let container = CKContainer(identifier: "iCloud.Rotta.CloudRotta")
    private var privateDatabase: CKDatabase {
        return container.privateCloudDatabase
    }
    private let recordType = "User"

    private init() {}

    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hashedData = SHA256.hash(data: data)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }

    func loginUser(email: String, password: String) async throws -> User? {
        print("🔍 Attempting to login user with email: \(email)")

        guard let user = try await getUserByEmail(email) else {
            print("❌ User not found for email: \(email)")
            return nil
        }

        let hashedPassword = hashPassword(password)

        if user.password == hashedPassword {
            print("✅ Login successful for user: \(user.name)")
            updateLoggedUser(with: user)
            return user
        } else {
            print("❌ Invalid password for user: \(email)")
        }

        return nil
    }

    func saveUser(_ user: User) async throws {
        if let _ = try? await getUserByEmail(user.email) {
            throw NSError(domain: "UserService", code: 409, userInfo: [
                NSLocalizedDescriptionKey: "An account with this email already exists."
            ])
        }

        let record = CKRecord(recordType: recordType)
        record["userID"] = user.id.uuidString
        record["name"] = user.name
        record["email"] = user.email
        record["password"] = hashPassword(user.password)
        record["favoriteDriver"] = user.favoriteDriver
        record["currentFormula"] = user.currentFormula
        record["dateCreated"] = user.dateCreated

        do {
            _ = try await privateDatabase.save(record)

            let hashedUser = User(
                id: user.id,
                name: user.name,
                email: user.email,
                password: hashPassword(user.password),
                favoriteDriver: user.favoriteDriver,
                currentFormula: user.currentFormula,
                dateCreated: user.dateCreated
            )

            updateLoggedUser(with: hashedUser)
            print("✅ User saved successfully to CloudKit")
        } catch let error as CKError {
            print("❌ CloudKit save error: \(error)")
        }
    }

    func updateUser(_ user: User) async throws {
        try await saveUser(user)
    }

    func updateLoggedUser(with user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        UserDefaults.standard.set(data, forKey: loggedUserKey)
    }

    func getLoggedUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: loggedUserKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }

    func getUserByEmail(_ email: String) async throws -> User? {
        let predicate = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: recordType, predicate: predicate)

        do {
            let (matchResults, _) = try await privateDatabase.records(matching: query)
            if let result = matchResults.first {
                let record = try result.1.get()
                return User(
                    id: UUID(uuidString: record["userID"] as? String ?? "") ?? UUID(),
                    name: record["name"] as? String ?? "",
                    email: record["email"] as? String ?? "",
                    password: record["password"] as? String ?? "",
                    favoriteDriver: record["favoriteDriver"] as? String,
                    currentFormula: record["currentFormula"] as? String ?? "Formula 2",
                    dateCreated: record["dateCreated"] as? Date ?? Date()
                )
            }
            return nil
        } catch {
            print("❌ CloudKit query error: \(error)")
            throw NSError(domain: "UserService", code: 1003, userInfo: [
                NSLocalizedDescriptionKey: "Failed to search for user. Please try again."
            ])
        }
    }

    func registerUser(name: String, email: String, password: String, favoriteDriver: String? = nil) async throws -> User {
        if let _ = try? await getUserByEmail(email) {
            throw NSError(domain: "UserService", code: 409, userInfo: [
                NSLocalizedDescriptionKey: "An account with this email already exists."
            ])
        }

        let hashedPassword = hashPassword(password)

        let user = User(
            id: UUID(),
            name: name,
            email: email,
            password: hashedPassword,
            favoriteDriver: favoriteDriver,
            currentFormula: Database.shared.getSelectedFormula().rawValue,
            dateCreated: Date()
        )

        try await saveUser(user)
        return user
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: loggedUserKey)
    }

    func getAll() async -> [User] {
        var users: [User] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)

        do {
            let results = try await privateDatabase.records(matching: query)
            for result in results.matchResults {
                do {
                    let record = try result.1.get()
                    let user = User(
                        id: UUID(uuidString: record["userID"] as? String ?? "") ?? UUID(),
                        name: record["name"] as? String ?? "",
                        email: record["email"] as? String ?? "",
                        password: record["password"] as? String ?? "",
                        favoriteDriver: record["favoriteDriver"] as? String,
                        currentFormula: record["currentFormula"] as? String ?? "Formula 2",
                        dateCreated: record["dateCreated"] as? Date ?? Date()
                    )
                    users.append(user)
                } catch {
                    print("Erro ao processar record User: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Erro ao buscar Users: \(error.localizedDescription)")
        }
        return users
    }

    func get(by id: UUID) async -> User? {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            let record = try await privateDatabase.record(for: recordID)
            return User(
                id: UUID(uuidString: record["userID"] as? String ?? "") ?? UUID(),
                name: record["name"] as? String ?? "",
                email: record["email"] as? String ?? "",
                password: record["password"] as? String ?? "",
                favoriteDriver: record["favoriteDriver"] as? String,
                currentFormula: record["currentFormula"] as? String ?? "Formula 2",
                dateCreated: record["dateCreated"] as? Date ?? Date()
            )
        } catch {
            print("Erro ao buscar User por ID: \(error.localizedDescription)")
            return nil
        }
    }

    func delete(by id: UUID) async throws {
        let recordID = CKRecord.ID(recordName: id.uuidString)
        do {
            _ = try await privateDatabase.deleteRecord(withID: recordID)
            print("✅ User deleted successfully from CloudKit")
        } catch {
            print("❌ CloudKit delete error: \(error)")
            throw NSError(domain: "UserService", code: 1004, userInfo: [
                NSLocalizedDescriptionKey: "Failed to delete user. Please try again."
            ])
        }
    }
}
