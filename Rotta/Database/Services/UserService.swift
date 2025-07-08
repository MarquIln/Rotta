//
//  UserService.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit
import CloudKit
import CryptoKit
import AuthenticationServices

class UserService {
    static let shared = UserService()
    private let loggedUserKey = "loggedUser"

    private let container = CKContainer(identifier: "iCloud.Rotta.CloudRotta")
    private var privateDatabase: CKDatabase {
        return container.publicCloudDatabase
    }
    private let recordType = "User"

    private init() {}

    func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hashedData = SHA256.hash(data: data)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }

    func loginUser(email: String, password: String) async throws -> User? {

        guard let user = try await getUserByEmail(email) else {
            return nil
        }

        guard let userPassword = user.password, !userPassword.isEmpty else {
            return nil
        }

        let hashedPassword = hashPassword(password)

        if userPassword == hashedPassword {
            updateLoggedUser(with: user)
            return user
        }

        return nil
    }

    func saveUser(_ user: User) async throws {
        if let _ = try? await getUserByEmail(user.email) {
            throw NSError(domain: "UserService", code: 409, userInfo: [
                NSLocalizedDescriptionKey: "An account with this email already exists."
            ])
        }

        let recordID = CKRecord.ID(recordName: user.id.uuidString)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        record["userID"] = user.id.uuidString
        record["name"] = user.name
        record["email"] = user.email
        record["password"] = user.password != nil ? hashPassword(user.password!) : nil
        record["favoriteDriver"] = user.favoriteDriver
        record["currentFormula"] = user.currentFormula
        record["dateCreated"] = user.dateCreated
        record["appleID"] = user.appleID
    
        if let imageData = user.profileImageData {
            record["profileImageData"] = imageData
        }

        do {
            _ = try await privateDatabase.save(record)
            
            let hashedUser = User(
                id: user.id,
                name: user.name,
                email: user.email,
                password: user.password != nil ? hashPassword(user.password!) : "",
                favoriteDriver: user.favoriteDriver,
                currentFormula: user.currentFormula ?? "Formula 2",
                dateCreated: user.dateCreated,
                appleID: user.appleID,
                profileImageData: user.profileImageData
            )
            
            updateLoggedUser(with: hashedUser)
        } catch {
            throw error
        }
    }

    func updateUser(_ user: User) async throws {
        let recordID = CKRecord.ID(recordName: user.id.uuidString)
        
        do {
            let record = try await privateDatabase.record(for: recordID)
            
            record["name"] = user.name
            record["email"] = user.email
            record["password"] = user.password != nil ? hashPassword(user.password!) : ""
            record["favoriteDriver"] = user.favoriteDriver
            record["currentFormula"] = user.currentFormula
            record["appleID"] = user.appleID
            
            if let imageData = user.profileImageData {
                record["profileImageData"] = imageData
            } else {
                record["profileImageData"] = nil
            }

            _ = try await privateDatabase.save(record)
            updateLoggedUser(with: user)
            
        } catch CKError.unknownItem {
            try await updateUserByQuery(user)
            
        } catch {
            throw error
        }
    }
    
    private func updateUserByQuery(_ user: User) async throws {
        let predicate = NSPredicate(format: "userID == %@", user.id.uuidString)
        let query = CKQuery(recordType: recordType, predicate: predicate)

        let result = try await privateDatabase.records(matching: query)
        guard let firstResult = result.matchResults.first else {
            throw NSError(domain: "UserService", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "User not found for update."
            ])
        }

        let (_, recordResult) = firstResult

        switch recordResult {
        case .success(let record):
            record["name"] = user.name
            record["email"] = user.email
            record["password"] = user.password != nil ? hashPassword(user.password!) : ""
            record["favoriteDriver"] = user.favoriteDriver
            record["currentFormula"] = user.currentFormula
            record["appleID"] = user.appleID
            
            if let imageData = user.profileImageData {
                record["profileImageData"] = imageData
            } else {
                record["profileImageData"] = nil
            }

            _ = try await privateDatabase.save(record)
            updateLoggedUser(with: user)

        case .failure(let error):
            throw error
        }
    }

    func updateLoggedUser(with user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            return 
        }
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
                    dateCreated: record["dateCreated"] as? Date ?? Date(),
                    appleID: record["appleID"] as? String,
                    profileImageData: record["profileImageData"] as? Data
                )
            }
            return nil
        } catch {
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
            dateCreated: Date(),
            profileImageData: nil
        )

        try await saveUser(user)
        return user
    }
    
    func registerAppleUser(
        credential: ASAuthorizationAppleIDCredential,
        customName: String? = nil,
        customEmail: String? = nil,
        favoriteDriver: String? = nil,
        preferredFormula: FormulaType = .formula2
    ) async throws -> User {
        let appleID = credential.user
        let userName = customName ?? credential.fullName?.givenName ?? "Apple User"
        let userEmail = customEmail ?? credential.email ?? ""

        if let _ = try? await getUserByAppleID(appleID) {
            throw NSError(domain: "UserService", code: 409, userInfo: [
                NSLocalizedDescriptionKey: "An account with this Apple ID already exists."
            ])
        }

        if !userEmail.isEmpty {
            if let _ = try? await getUserByEmail(userEmail) {
                throw NSError(domain: "UserService", code: 409, userInfo: [
                    NSLocalizedDescriptionKey: "An account with this email already exists."
                ])
            }
        }
        
        let user = User(
            id: UUID(),
            name: userName,
            email: userEmail,
            password: "",
            favoriteDriver: favoriteDriver,
            currentFormula: preferredFormula.rawValue,
            dateCreated: Date(),
            appleID: appleID,
            profileImageData: nil
        )
        
        try await saveUser(user)
        
        if let savedUser = getLoggedUser() {
            return savedUser
        } else {
            return user
        }
    }
    
    func logout() async {
        UserDefaults.standard.removeObject(forKey: loggedUserKey)
        await Database.shared.clearProfileImageData()
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
                        dateCreated: record["dateCreated"] as? Date ?? Date(),
                        appleID: record["appleID"] as? String,
                        profileImageData: record["profileImageData"] as? Data
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
                dateCreated: record["dateCreated"] as? Date ?? Date(),
                appleID: record["appleID"] as? String,
                profileImageData: record["profileImageData"] as? Data
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
        } catch {
            throw NSError(domain: "UserService", code: 1004, userInfo: [
                NSLocalizedDescriptionKey: "Failed to delete user. Please try again."
            ])
        }
    }
    
    func getUserByAppleID(_ appleID: String) async throws -> User? {
        let predicate = NSPredicate(format: "appleID == %@", appleID)
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
                    dateCreated: record["dateCreated"] as? Date ?? Date(),
                    appleID: record["appleID"] as? String,
                    profileImageData: record["profileImageData"] as? Data
                )
            }
            return nil
        } catch {
            throw NSError(domain: "UserService", code: 1003, userInfo: [
                NSLocalizedDescriptionKey: "Failed to search for user. Please try again."
            ])
        }
    }
}

// MARK: - Profile Image Management
extension UserService {
    func updateUserProfileImage(_ imageData: Data) async throws {
        guard var user = getLoggedUser() else {
            throw NSError(domain: "UserService", code: 1001, userInfo: [
                NSLocalizedDescriptionKey: "No logged user found."
            ])
        }
        
        print("🔄 Updating profile image for user: \(user.name)")
        user.profileImageData = imageData
        
        do {
            try await updateUser(user)
            print("✅ Profile image updated successfully for user: \(user.name)")
        } catch {
            print("❌ Failed to update profile image: \(error)")
            throw error
        }
    }
    
    func getUserProfileImage() -> Data? {
        guard let user = getLoggedUser() else {
            return nil
        }
        
        if let imageData = user.profileImageData {
            return imageData
        }
        
        return nil
    }
    
    func clearUserProfileImage() async throws {
        guard var user = getLoggedUser() else {
            throw NSError(domain: "UserService", code: 1001, userInfo: [
                NSLocalizedDescriptionKey: "No logged user found."
            ])
        }
        
        user.profileImageData = nil
        try await updateUser(user)
    }
}
