//
//  Database.swift
//  Rotta
//
//  Created by Marcos on 12/06/25.
//

import CoreData
import Foundation

class Database {
    static var shared = Database()

    var context: NSManagedObjectContext?

    private let currentDatabaseVersion = "1.0.0"
    private let databaseVersionKey = "DatabaseVersion"
    private let firstLaunchKey = "HasLaunchedBefore"
    
    private init() {}

    func initializeDatabase() {
        checkAndSeedIfNeeded()
    }

    func checkAndSeedIfNeeded() {
        let userDefaults = UserDefaults.standard
        let hasLaunchedBefore = userDefaults.bool(forKey: firstLaunchKey)
        let storedVersion = userDefaults.string(forKey: databaseVersionKey)

        let shouldSeed =
            !hasLaunchedBefore || storedVersion != currentDatabaseVersion

        if shouldSeed {
            print(
                "Database seed needed - First launch: \(!hasLaunchedBefore), Version changed: \(storedVersion != currentDatabaseVersion)"
            )

            if hasLaunchedBefore && storedVersion != currentDatabaseVersion {
                clearExistingData()
            }

            seedDatabase()

            userDefaults.set(true, forKey: firstLaunchKey)
            userDefaults.set(currentDatabaseVersion, forKey: databaseVersionKey)
            userDefaults.synchronize()
            print("Database version updated to: \(currentDatabaseVersion)")

        } else {
            print(
                "Database already seeded and up to date (version: \(currentDatabaseVersion))"
            )
        }

    }

    private func clearExistingData() {
        print("Clearing existing data due to database version change...")

        guard let context = context else { return }

        let entityNames = [
            "Formula", "Scuderia", "Driver", "Track", "Glossary", "Rule", "Car",
            "Component", "Event",
        ]

        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
                entityName: entityName
            )
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
                print("Cleared \(entityName) entities")
            } catch {
                print("Error clearing \(entityName): \(error)")
            }
        }

        save()
    }

    func save() {
        if let context, context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    func getFormulaId(for formulaName: String) -> UUID? {
        let formulas = getAllFormulas()
        return formulas.first { $0.name == formulaName }?.id
    }
}

extension Database {
    func forceDatabaseReset() {
        print("Forcing database reset...")
        clearExistingData()
        seedDatabase()

        let userDefaults = UserDefaults.standard
        userDefaults.set(currentDatabaseVersion, forKey: databaseVersionKey)
        userDefaults.synchronize()

        print("Database reset completed!")
    }

    func getCurrentStoredDatabaseVersion() -> String? {
        return UserDefaults.standard.string(forKey: databaseVersionKey)
    }

    func getExpectedDatabaseVersion() -> String {
        return currentDatabaseVersion
    }

    func isDatabaseUpToDate() -> Bool {
        let storedVersion = UserDefaults.standard.string(
            forKey: databaseVersionKey
        )
        return storedVersion == currentDatabaseVersion
    }
}
