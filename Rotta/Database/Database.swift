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
    private var privateDatabase: CKDatabase {
        return container.privateCloudDatabase
    }
    
    private let formulaService = FormulaService()
    private let driverService = DriverService()
    private let scuderiaService = ScuderiaService()
    private let eventService = EventService()
    private let carService = CarService()
    private let componentService = ComponentService()
    private let ruleService = RuleService()
    private let glossaryService = GlossaryService()
    
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
    
    func getDriver(by id: UUID) async -> DriverModel? {
        return await driverService.get(by: id)
    }
    
    func getDriversByFormula(idFormula: UUID) async -> [DriverModel] {
        return await driverService.getByFormula(idFormula: idFormula)
    }
    
    func getDriversByScuderia(scuderiaId: UUID) async -> [DriverModel] {
        return await driverService.getByScuderia(scuderiaId: scuderiaId)
    }
    
    func addDriver(name: String, country: String, number: Int16, points: Double, scuderia: UUID, idFormula: UUID) async {
        await driverService.add(name: name, country: country, number: number, points: points, scuderia: scuderia, idFormula: idFormula)
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
    
    func addScuderia(name: String, logo: String, points: Double, idFormula: UUID) async {
        await scuderiaService.add(name: name, logo: logo, points: points, idFormula: idFormula)
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
    
    func addEvent(name: String, date: Date? = nil, startTime: Date? = nil, idFormula: UUID? = nil) async {
        await eventService.add(name: name, date: date, startTime: startTime, idFormula: idFormula)
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
        // Talvez criar TrackService similar caso necessário
        return []
    }
    
    func getTrack(by id: UUID) async -> TrackModel? {
        return nil
    }
    
    func getAllTracksByFormula(by idFormula: UUID) async -> [TrackModel] {
        return []
    }
    
    func addTrack(name: String? = nil, location: String? = nil, distance: Double = 0.0, idFormula: [UUID]? = nil) async {
        // Implementação futura em TrackService
    }
    
    // MARK: - Component Functions
    func getAllComponents() async -> [ComponentModel] {
        return await componentService.getAll()
    }
    
    func getComponent(by id: UUID) async -> ComponentModel? {
        return await componentService.get(by: id)
    }
    
    func addComponent(name: String? = nil, details: String? = nil, image: String? = nil) async {
        await componentService.add(name: name, details: details, image: image)
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
    
    func addGlossaryTerm(name: String? = nil, details: String? = nil) async {
        await glossaryService.add(name: name, details: details)
    }
}
