//
//  Database.swift
//  Rotta
//
//  Created by Marcos on 12/06/25.
//

import Foundation
import CloudKit

class Database {
    static var shared = Database()
    
    private let container = CKContainer(identifier: "iCloud.Rotta.CloudRotta")
    private var publicDatabase: CKDatabase {
        return container.publicCloudDatabase
    }
    
    private let formulaService = FormulaService()
    private let driverService = DriverService()
    private let scuderiaService = ScuderiaService()
    private let eventService = EventService()
    private let carService = CarService()
    private let componentService = ComponentService()
    private let ruleService = RuleService()
    private let glossaryService = GlossaryService()
    private let trackService = TrackService()

    private let userDefaults = UserDefaults.standard
    let appleUserIdentifierKey = "appleUserIdentifier"
    private let selectedFormulaKey = "selectedFormula"
    private let profileImageKey = "profileImage"
    
    private init() {}
    
    // MARK: - Formula Functions
    func getAllFormulas() async -> [FormulaModel] {
        return await formulaService.getAll()
    }
    
    func getFormula(by id: UUID) async -> FormulaModel? {
        return await formulaService.get(by: id)
    }
    
    func addFormula(name: String, color: String) async {
        await formulaService.add(name: name, color: color)
    }
    
    // MARK: - Driver Functions
    func getAllDrivers() async -> [DriverModel] {
        return await driverService.getAll()
    }
    
    func getDriversByFormula(idFormula: UUID) async -> [DriverModel] {
        return await driverService.getByFormula(idFormula: idFormula)
    }
    
    func getDriversByScuderia(scuderiaId: UUID) async -> [DriverModel] {
        return await driverService.getByScuderia(scuderiaId: scuderiaId)
    }
    
    func addDriver(name: String, country: String, number: Int16, points: Int16, scuderia: String, idFormula: UUID, photo: String, scuderiaLogo: String, height: String, birthDate: Date, championship: String, details: String) async {
        await driverService.add(name: name, country: country, number: number, points: Int16(points), scuderia: scuderia, idFormula: idFormula, photo: photo, scuderiaLogo: scuderiaLogo, height: height, birthDate: birthDate, championship: championship, details: details)
    }
    
    // MARK: - Scuderia Functions
    func getAllScuderias() async -> [ScuderiaModel] {
        return await scuderiaService.getAll()
    }
    
    func getScuderia(by id: UUID) async -> ScuderiaModel? {
        return await scuderiaService.get(by: id)
    }
    
    func getScuderiasByFormula(idFormula: UUID) async -> [ScuderiaModel] {
        return await scuderiaService.getByFormula(idFormula: idFormula)
    }
    
    func addScuderia(name: String, logo: String, points: Double, historicPoints: Int16, idFormula: UUID, country: String, pole: Int16, victory: Int16, podium: Int16, details: String) async {
        await scuderiaService.add(name: name, logo: logo, points: points, historicPoints: historicPoints, idFormula: idFormula, country: country, pole: pole, victory: victory, podium: podium, details: details)
    }
    
    // MARK: - Event Functions
    func getAllEvents() async -> [EventModel] {
        return await eventService.getAll()
    }
    
    func getEvent(by id: UUID) async -> EventModel? {
        return await eventService.get(by: id)
    }
    
    func getAllEventsByFormula(by idFormula: UUID) async -> [EventModel] {
        return await eventService.getByFormula(idFormula: idFormula)
    }
    
    func getEventsOnDate(_ date: Date) async -> [EventModel] {
        return await eventService.getOnDate(date)
    }
    
    func addEvent(roundNumber: Int16, country: String, name: String, date: Date? = nil, startTime: String, endTime: String, idFormula: UUID? = nil) async {
        await eventService.add(roundNumber: roundNumber, country: country, name: name, date: date, startTime: startTime, endTime: endTime, idFormula: idFormula)
    }
    
    // MARK: - Car Functions
    func getAllCars() async -> [CarModel] {
        return await carService.getAll()
    }
    
    func getCar(by id: UUID) async -> CarModel? {
        return await carService.get(by: id)
    }
    
    func getAllCarsByFormula(by idFormula: UUID) async -> [CarModel] {
        return await carService.getByFormula(idFormula: idFormula)
    }
    
    func getCarsByComponent(componentId: UUID) async -> [CarModel] {
        return await carService.getByComponent(componentId: componentId)
    }
    
    func addCar(idComponents: [UUID], idFormula: UUID, image: String? = nil) async {
        await carService.add(idComponents: idComponents, idFormula: idFormula, image: image)
    }
    
    // MARK: - Track Functions
    func getAllTracks() async -> [TrackModel] {
        return await trackService.getAll()
    }
    
    func getTrack(by id: UUID) async -> TrackModel? {
        return await trackService.get(by: id)
    }
    
    func getAllTracksByFormula(by idFormula: UUID) async -> [TrackModel] {
        return await trackService.getByFormula(idFormula: idFormula)
    }
    
    func addTrack(name: String, location: String, distance: Double = 0.0, idFormula: [UUID]) async {
        return await trackService.add(name: name, location: location, distance: distance, idFormula: idFormula)
    }
    
    // MARK: - Component Functions
    func getAllComponents() async -> [ComponentModel] {
        return await componentService.getAll()
    }
    
    func getComponent(by id: UUID) async -> ComponentModel? {
        return await componentService.get(by: id)
    }
    
    func addComponent(name: String? = nil, details: String? = nil, property: String? = nil, image: String? = nil) async {
        await componentService.add(name: name, details: details, property: property, image: image)
    }
    
    // MARK: - Rule Functions
    func getAllRules() async -> [RuleModel] {
        return await ruleService.getAll()
    }
    
    func getRule(by id: UUID) async -> RuleModel? {
        return await ruleService.get(by: id)
    }
    
    func getAllRulesByFormula(by idFormula: UUID) async -> [RuleModel] {
        return await ruleService.getByFormula(idFormula: idFormula)
    }
    
    func addRule(name: String? = nil, details: String? = nil, idFormula: UUID? = nil) async {
        await ruleService.add(name: name, details: details, idFormula: idFormula)
    }
    
    // MARK: - Glossary Functions
    func getAllGlossaryTerms() async -> [GlossaryModel] {
        return await glossaryService.getAll()
    }
    
    func getGlossaryTerm(by id: UUID) async -> GlossaryModel? {
        return await glossaryService.get(by: id)
    }
    
    func addGlossaryTerm(title: String? = nil, details: String? = nil, subtitle: String? = nil, image: String? = nil) async {
        await glossaryService.add(title: title, details: details, subtitle: subtitle, image: image)
    }
    
    // MARK: - Convenience Methods with FormulaType
    
    func getDrivers(for formula: FormulaType) async -> [DriverModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getDriversByFormula(idFormula: targetFormula.id)
    }
    
    func getScuderias(for formula: FormulaType) async -> [ScuderiaModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getScuderiasByFormula(idFormula: targetFormula.id)
    }
    
    func getEvents(for formula: FormulaType) async -> [EventModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getAllEventsByFormula(by: targetFormula.id)
    }
    
    func getRules(for formula: FormulaType) async -> [RuleModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getAllRulesByFormula(by: targetFormula.id)
    }
    
    func getCars(for formula: FormulaType) async -> [CarModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getAllCarsByFormula(by: targetFormula.id)
    }
    
    func getTracks(for formula: FormulaType) async -> [TrackModel] {
        let formulas = await getAllFormulas()
        guard let targetFormula = formulas.first(where: { $0.name == formula.rawValue }) else {
            return []
        }
        return await getAllTracksByFormula(by: targetFormula.id)
    }

    // MARK: - User Preferences Functions
    func saveSelectedFormula(_ formula: FormulaType) {
        userDefaults.set(formula.rawValue, forKey: selectedFormulaKey)
        if var user = UserService.shared.getLoggedUser() {
            user.currentFormula = formula.rawValue
            Task {
                do {
                    try await UserService.shared.updateUser(user)
                } catch {
                    print("Failed to update user with new formula: \(error)")
                }
            }
        }
    }

    func getSelectedFormula() -> FormulaType {
        if let user = UserService.shared.getLoggedUser() {
            if let formula = FormulaType(rawValue: user.currentFormula ?? "Formula 2") {
                return formula
            }
        }
        guard let formulaString = userDefaults.string(forKey: selectedFormulaKey),
              let formula = FormulaType(rawValue: formulaString) else {
            return .formula2
        }
        return formula
    }

    func hasSelectedFormula() -> Bool {
        return userDefaults.string(forKey: selectedFormulaKey) != nil
    }

    func clearSelectedFormula() {
        userDefaults.removeObject(forKey: selectedFormulaKey)
    }

    func saveProfileImageData(_ data: Data) async {
        do {
            try await UserService.shared.updateUserProfileImage(data)
        } catch {
            print("❌ Error saving profile image: \(error)")
        }
    }

    func getProfileImageData() -> Data? {
        if let imageData = UserService.shared.getUserProfileImage() {
            return imageData
        }
        return nil
    }

    func clearProfileImageData() async {
        do {
            try await UserService.shared.clearUserProfileImage()
        } catch {
            print("❌ Error clearing profile image: \(error)")
        }
    }
}
