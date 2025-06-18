//
//  CloudKitSeed.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import Foundation
import CloudKit

class CloudKitSeed {
    var database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func seedDatabase() async {
        print("Starting CloudKit database seed...")
        
        if await isDatabaseAlreadySeeded() {
            print("Database already contains data, skipping seed...")
            return
        }
        
        await seedFormulas()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedAllScuderias()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedAllDrivers()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedTracks()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedGlossaryTerms()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
                
        await seedAllRules()
         
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedEvents()
         
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedComponents()
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        await seedCars()
         
        Self.markSeedAsCompleted()
        
        print("CloudKit database seed completed!")
    }
    
    // MARK: - Database Check Methods
    
    private func isDatabaseAlreadySeeded() async -> Bool {
        print("Checking if database is already seeded...")
        
        if Self.isSeedCompleted() {
            print("UserDefaults indicates database is seeded")
            return true
        }
        
        let formulas = await database.getAllFormulas()
        if !formulas.isEmpty {
            print("Found \(formulas.count) formulas in database - already seeded")
            Self.markSeedAsCompleted()
            return true
        }
        
        print("Database appears to be empty - proceeding with seed")
        return false
    }
    
    func forceSeedDatabase() async {
        print("Force seeding database...")
        Self.markSeedAsNotCompleted()
        await seedDatabase()
    }
    
    func resetAndSeedDatabase() async {
        print("Resetting and seeding database...")
        
        Self.markSeedAsNotCompleted()
        await seedDatabase()
    }
    
    private func seedFormulas() async {
        print("Seeding formulas...")
        
        let existingFormulas = await database.getAllFormulas()
        if !existingFormulas.isEmpty {
            print("Formulas already exist, skipping...")
            return
        }
         
        let formulas = [
//            ("Formula 1 Academy", "#FF0000"),
            ("Formula 2", "#0000FF"),
//            ("Formula 3", "#00FF00"),
        ]
        
        for formula in formulas {
            await database.addFormula(name: formula.0, color: formula.1)
        }
    }
    
    private func seedAllScuderias() async {
        print("Seeding scuderias...")
        
        // Verificar se já existem scuderias
        let existingScuderias = await database.getAllScuderias()
        if !existingScuderias.isEmpty {
            print("Scuderias already exist, skipping...")
            return
        }
         
        let formulas = await database.getAllFormulas()

        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id else {
            print("Formulas not found after retries")
            return
        }
        
//        let f1AcademyTeams = [
//            ("Campos Racing", "campos_logo", 108.0),
//            ("MP Motorsport", "mp_logo", 94.0),
//            ("PREMA Racing", "prema_logo", 88.0),
//            ("Rodin Motorsport", "rodin_logo", 34.0),
//            ("ART Grand Prix", "art_logo", 5.0),
//            ("Hitech TGR", "hitech_logo", 1.0)
//        ]
//        
//        for team in f1AcademyTeams {
//            await database.addScuderia(name: team.0, logo: team.1, points: team.2, idFormula: f1AcademyId)
//        }
        
        let f2Teams = [
            ("Campos Racing", "campos_logo", 128.0),
            ("Hitech TGR", "hitech_logo", 102.0),
            ("MP Motorsport", "mp_logo", 96.0),
            ("DAMS Lucas Oil", "dams_logo", 94.0),
            ("Rodin Motorsport", "rodin_logo", 89.0),
            ("Invicta Racing", "invicta_logo", 78.0),
            ("PREMA Racing", "prema_logo", 57.0),
            ("ART Grand Prix", "art_logo", 46.0),
            ("AIX Racing", "aix_logo", 11.0),
            ("Van Amersfoort Racing", "var_logo", 10.0),
            ("TRIDENT", "trident_logo", 1.0)
        ]
        
        for team in f2Teams {
            await database.addScuderia(name: team.0, logo: team.1, points: team.2, idFormula: f2Id)
        }
        
//        let f3Teams = [
//            ("TRIDENT", "trident_logo", 176.0),
//            ("Campos Racing", "campos_logo", 130.0),
//            ("MP Motorsport", "mp_logo", 126.0),
//            ("Van Amersfoort Racing", "var_logo", 106.0),
//            ("Rodin Motorsport", "rodin_logo", 90.0),
//            ("ART Grand Prix", "art_logo", 90.0),
//            ("Hitech TGR", "hitech_logo", 37.0),
//            ("AIX Racing", "aix_logo", 27.0),
//            ("DAMS Lucas Oil", "dams_logo", 10.0),
//            ("PREMA Racing", "prema_logo", 8.0)
//        ]
//        
//        for team in f3Teams {
//            await database.addScuderia(name: team.0, logo: team.1, points: team.2, idFormula: f3Id)
//        }
    }
    
    private func seedAllDrivers() async {
        print("Seeding drivers...")
        
        // Verificar se já existem drivers
        let existingDrivers = await database.getAllDrivers()
        if !existingDrivers.isEmpty {
            print("Drivers already exist, skipping...")
            return
        }
         
        let formulas = await database.getAllFormulas()
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id else {
            print("Formulas not found")
            return
        }
        
        let allScuderias = await database.getAllScuderias()
//        
//        let f1AcademyDrivers = [
//            ("Maya Weug", "Spain", 47, "Campos Racing", 64.0),
//            ("Lia Pin", "France", 1, "MP Motorsport", 63.0),
//            ("Sophia Flörsch", "Germany", 2, "PREMA Racing", 55.0),
//            ("Palou Toni", "Spain", 3, "Rodin Motorsport", 44.0),
//            ("Larson Kyle", "United States", 4, "MP Motorsport", 28.0),
//            ("Llorca Marc", "Spain", 5, "Campos Racing", 23.0),
//            ("Hauger Dennis", "Norway", 6, "Hitech TGR", 13.0),
//            ("Gada Reema", "United Arab Emirates", 7, "PREMA Racing", 12.0),
//            ("Felipe Drugovich", "Brazil", 8, "ART Grand Prix", 10.0),
//            ("Ferris Jack", "United Kingdom", 9, "Rodin Motorsport", 9.0),
//            ("Aurelia Nobels", "Belgium", 10, "ART Grand Prix", 3.0),
//            ("Lia Block", "United States", 11, "Rodin Motorsport", 2.0),
//            ("Caterina Ciacci", "Italy", 12, "Hitech TGR", 2.0),
//            ("Ana Segura", "Mexico", 13, "Campos Racing", 1.0),
//            ("Chloe Chong", "United States", 14, "Hitech TGR", 1.0)
//        ]
//        
//        for driver in f1AcademyDrivers {
//            if let scuderia = allScuderias.first(where: { $0.name == driver.3 && $0.idFormula == f1AcademyId }) {
//                await database.addDriver(
//                    name: driver.0,
//                    country: driver.1,
//                    number: Int16(driver.2),
//                    points: driver.4,
//                    scuderia: scuderia.id,
//                    idFormula: f1AcademyId
//                )
//            }
//        }
        
        let f2Drivers = [
            ("Alex Dunne", "Ireland", 1, "MP Motorsport", 87.0),
            ("Richard Verschoor", "Netherlands", 2, "MP Motorsport", 84.0),
            ("Arvid Lindblad", "United Kingdom", 3, "DAMS Lucas Oil", 79.0),
            ("Jak Crawford", "United States", 4, "DAMS Lucas Oil", 73.0),
            ("Luke Browning", "United Kingdom", 5, "Hitech TGR", 73.0),
            ("Leonardo Fornaroli", "Argentina", 6, "Invicta Racing", 66.0),
            ("Josep Maria Marti", "Spain", 7, "Campos Racing", 49.0),
            ("Victor Martins", "France", 8, "ART Grand Prix", 41.0),
            ("Sebastian Montoya", "Colombia", 9, "Campos Racing", 36.0),
            ("Dino Beganovic", "Sweden", 10, "Rodin Motorsport", 29.0),
            ("Kush Maini", "India", 11, "Invicta Racing", 21.0),
            ("Gabriele Mini", "Italy", 12, "PREMA Racing", 21.0),
            ("Enzo Gomes", "Brazil", 13, "Hitech TGR", 12.0),
            ("Roman Stanek", "Czech Republic", 14, "Invicta Racing", 12.0),
            ("Joshua Durksen", "Paraguay", 15, "AIX Racing", 11.0),
            ("Rafael Villagomez", "Mexico", 16, "Van Amersfoort Racing", 10.0),
            ("Miyata Shingo", "Japan", 17, "ART Grand Prix", 5.0),
            ("Amaury Cordeel", "Belgium", 18, "TRIDENT", 2.0),
            ("Sami Meguetounif", "France", 19, "TRIDENT", 1.0),
            ("Taylor Barnard", "United Kingdom", 20, "Rodin Motorsport", 0.0),
            ("Paul Aron", "Estonia", 21, "PREMA Racing", 0.0),
            ("Isack Hadjar", "France", 22, "Van Amersfoort Racing", 0.0)
        ]
        
        for driver in f2Drivers {
            if let scuderia = allScuderias.first(where: { $0.name == driver.3 && $0.idFormula == f2Id }) {
                await database.addDriver(
                    name: driver.0,
                    country: driver.1,
                    number: Int16(driver.2),
                    points: driver.4,
                    scuderia: scuderia.id,
                    idFormula: f2Id
                )
            }
        }
        
//        let f3Drivers = [
//            ("Rafael Camara", "Brazil", 1, "Campos Racing", 105.0),
//            ("Nikola Tsolov", "Bulgaria", 2, "ART Grand Prix", 79.0),
//            ("Tim Tramnitz", "Germany", 3, "TRIDENT", 70.0),
//            ("Charlie Wurz", "Austria", 4, "Hitech TGR", 56.0),
//            ("Tuukka Taponen", "Finland", 5, "MP Motorsport", 51.0),
//            ("Kacper Sztuka", "Poland", 6, "MP Motorsport", 45.0),
//            ("Noel Ramzi", "Singapore", 7, "Rodin Motorsport", 45.0),
//            ("Martinius Stenshorne", "Norway", 8, "Hitech TGR", 43.0),
//            ("Callum Voisin", "United Kingdom", 9, "Rodin Motorsport", 41.0),
//            ("Gabriel Biller", "Denmark", 10, "Campos Racing", 38.0),
//            ("Laurens van Hoepen", "Netherlands", 11, "ART Grand Prix", 37.0),
//            ("Mari Boya", "Spain", 12, "TRIDENT", 36.0),
//            ("Sami Meguetounif", "France", 13, "Van Amersfoort Racing", 36.0),
//            ("Domenico Lovera", "Italy", 14, "DAMS Lucas Oil", 18.0),
//            ("Nikita Bedrin", "Italy", 15, "AIX Racing", 17.0),
//            ("James Wharton", "Australia", 16, "PREMA Racing", 15.0),
//            ("Tasanapol Inthraphuvasak", "Thailand", 17, "Rodin Motorsport", 15.0),
//            ("Alex Dunne", "Ireland", 18, "MP Motorsport", 11.0),
//            ("Max Esterson", "United States", 19, "Hitech TGR", 11.0),
//            ("Ugo Ugochukwu", "United States", 20, "PREMA Racing", 10.0),
//            ("Matías Zagazeta", "Peru", 21, "DAMS Lucas Oil", 6.0),
//            ("Arvid Lindblad", "United Kingdom", 22, "PREMA Racing", 4.0),
//            ("Leonardo Fornaroli", "Argentina", 23, "TRIDENT", 4.0),
//            ("Luke Browning", "United Kingdom", 24, "Campos Racing", 3.0),
//            ("James Wharton", "Australia", 25, "PREMA Racing", 0.0),
//            ("William Alatalo", "Finland", 26, "Van Amersfoort Racing", 0.0),
//            ("Brando Badoer", "Italy", 27, "PREMA Racing", 0.0)
//        ]
//        
//        for driver in f3Drivers {
//            if let scuderia = allScuderias.first(where: { $0.name == driver.3 && $0.idFormula == f3Id }) {
//                await database.addDriver(
//                    name: driver.0,
//                    country: driver.1,
//                    number: Int16(driver.2),
//                    points: driver.4,
//                    scuderia: scuderia.id,
//                    idFormula: f3Id
//                )
//            }
//        }
    }
    
    private func seedTracks() async {
        print("Seeding tracks...")
        
        let existingTracks = await database.getAllTracks()
        if !existingTracks.isEmpty {
            print("Tracks already exist, skipping...")
            return
        }
         
        let tracks = [
            ("Bahrain International Circuit", "Bahrain", 5.412),
            ("Circuit de Monaco", "Monaco", 3.337),
            ("Circuit de Barcelona-Catalunya", "Spain", 4.675),
            ("Hungaroring", "Hungary", 4.381),
            ("Circuit de Spa-Francorchamps", "Belgium", 7.004),
            ("Autodromo Nazionale Monza", "Italy", 5.793),
            ("Baku City Circuit", "Azerbaijan", 6.003),
            ("Silverstone Circuit", "United Kingdom", 5.891),
            ("Red Bull Ring", "Austria", 4.318),
            ("Yas Marina Circuit", "United Arab Emirates", 5.281),
            ("Circuit Zandvoort", "Netherlands", 4.259),
            ("Circuit Paul Ricard", "France", 5.842),
            ("Imola Circuit", "Italy", 4.909),
            ("Valencia Circuit", "Spain", 4.005),
            ("Jerez Circuit", "Spain", 4.428),
            ("Mugello Circuit", "Italy", 5.245)
        ]
         
        for track in tracks {
            await database.addTrack(
                name: track.0,
                location: track.1,
                distance: track.2,
                idFormula: []
            )
        }
     }
    
    private func seedGlossaryTerms() async {
        print("Seeding glossary terms...")
        
        let existingTerms = await database.getAllGlossaryTerms()
        if !existingTerms.isEmpty {
            print("Glossary terms already exist, skipping...")
            return
        }
        
        let glossaryTerms: [(title: String, subtitle: String, details: String)] = [
                    ("DRS", "Drag Reduction System", "A movable flap on the rear wing that reduces drag and increases straight-line speed."),
                    ("ERS", "Energy Recovery System", "A system that recovers energy from braking and exhaust heat to provide additional power."),
                    ("Pole Position", "Posição de Pista", "The first position on the starting grid, awarded to the fastest qualifier."),
                    ("Fastest Lap", "Volta Mais Rápida", "The quickest lap time recorded during a race, often rewarded with an extra championship point."),
                    ("DNF", "Did Not Finish", "When a driver fails to complete the race due to mechanical failure, accident, or other issues."),
                    ("DNS", "Did Not Start", "When a driver is unable to start the race."),
                    ("DSQ", "Disqualified", "When a driver is excluded from race results due to rule violations."),
                    ("Safety Car", "Carro de Segurança", "A car deployed to slow down the field during dangerous conditions on track."),
                    ("Virtual Safety Car", "Carro Virtual de Segurança", "An electronic system that limits drivers' speeds during caution periods."),
                    ("Pit Stop", "Parada nos Boxes", "A planned stop in the pit lane for tire changes, fuel, or repairs."),
                    ("Undercut", "Undercut", "Gaining track position by pitting earlier than a rival and using fresh tires."),
                    ("Overcut", "Overcut", "Staying out longer than rivals to gain track position through tire strategy."),
                    ("Slipstream", "Efeito esteira", "Following closely behind another car to reduce air resistance and increase speed."),
                    ("Dirty Air", "Ar Turvo", "Disturbed airflow behind a car that reduces downforce for following vehicles."),
                    ("Apex", "Vértice", "The innermost point of a corner where drivers aim to position their car."),
                    ("Chicane", "Chicane", "A sequence of tight turns designed to slow cars down."),
                    ("Kerb", "Meio-Fio", "Raised or painted strips marking the edge of the racing surface."),
                    ("Marshals", "Comissários", "Volunteers who ensure safety and enforce rules during racing events."),
                    ("Parc Fermé", "Parc Fermé", "Rules that limit car modifications between qualifying and race."),
                    ("Formation Lap", "Volta de Formação", "A lap completed before the race start to warm up tires and check conditions.")
                ]

                for term in glossaryTerms {
                    await database.addGlossaryTerm(
                        title:    term.title,
                        details:  term.details,
                        subtitle: term.subtitle,
                       
                    )
                }
     }
    
    private func seedAllRules() async {
        print("Seeding rules...")
        
        let existingRules = await database.getAllRules()
        if !existingRules.isEmpty {
            print("Rules already exist, skipping...")
            return
        }
        
        let formulas = await database.getAllFormulas()
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id else {
            print("Formulas not found")
            return
        }
        
//        let f1AcademyRules = [
//            ("Race Weekend Format", "Each weekend consists of one practice session, one qualifying session, and two races."),
//            ("Points System", "Points awarded to the top 10 finishers in each race, with 25 points for the winner."),
//            ("Car Specifications", "All drivers use identical Tatuus T-318 Formula 4 cars with Autotecnica engines."),
//            ("Driver Eligibility", "Championship exclusively for female drivers aged 16 and above."),
//            ("Tire Regulations", "All drivers must use the same tire compound provided by Pirelli."),
//            ("Fuel Regulations", "All cars carry standardized fuel loads with no refueling during races."),
//            ("Safety Equipment", "Drivers must wear approved helmets, HANS devices, and fire-resistant suits."),
//            ("Race Duration", "Races run for 30 minutes plus one additional lap after time expires.")
//        ]
//        
//        for rule in f1AcademyRules {
//            await database.addRule(
//                name: rule.0,
//                details: rule.1,
//                idFormula: f1AcademyId
//            )
//        }
        
        let f2Rules = [
            ("Race Weekend Format", "Each weekend includes practice, qualifying, one sprint race, and one feature race."),
            ("Points System", "Different points systems for feature races (25 for winner) and sprint races (15 for winner)."),
            ("Car Specifications", "All teams use identical Dallara F2 2018 chassis with Mecachrome V6 engines."),
            ("DRS Usage", "Drivers can use DRS in designated zones when within 1 second of the car ahead."),
            ("Tire Regulations", "Pirelli provides soft, medium, and hard compounds. Drivers must use two diferentes compounds in feature races."),
            ("Fuel Regulations", "No refueling allowed durante races. Cars start with enough fuel for the entire race."),
            ("Reverse Grid", "Sprint race grid is determined by reverse order of top 8 from qualifying."),
            ("Feature Race Duration", "Feature races run for approximately 45 minutes plus one additional lap."),
            ("Sprint Race Duration", "Sprint races run for aproximadamente 25 minutes plus one additional lap."),
            ("Mandatory Pit Stop", "Drivers must make at least one pit stop during feature races.")
        ]
        
        for rule in f2Rules {
            await database.addRule(
                name: rule.0,
                details: rule.1,
                idFormula: f2Id
            )
        }
        
//        let f3Rules = [
//            ("Race Weekend Format", "Each weekend consists of one practice session, one qualifying session, and two races."),
//            ("Points System", "Points awarded to the top 10 finishers in each race, with 25 points for the winner."),
//            ("Car Specifications", "All teams use identical Dallara F3 2019 chassis with Mecachrome 3.4L V6 engines."),
//            ("DRS Usage", "Drivers can use DRS in designated zones when within 1 second of the car ahead."),
//            ("Tire Regulations", "Pirelli provides one tire compound per weekend. All drivers must use the same compound."),
//            ("Fuel Regulations", "No refueling allowed during races. Cars start with enough fuel for the entire race."),
//            ("Reverse Grid", "Race 2 grid is determined by reverse order of top 8 from Race 1 results."),
//            ("Race Duration", "Both races run for approximately 40 minutes plus one additional lap."),
//            ("Age Restrictions", "Drivers must be at least 16 years old to compete in the championship."),
//            ("Engine Allocation", "Teams are allocated a specific number of engines per season to control costs.")
//        ]
//        
//        for rule in f3Rules {
//            await database.addRule(
//                name: rule.0,
//                details: rule.1,
//                idFormula: f3Id
//            )
//        }
    }
    
    private func seedEvents() async {
        print("Seeding events...")
        
        let existingEvents = await database.getAllEvents()
        if !existingEvents.isEmpty {
            print("Events already exist, skipping...")
            return
        }
         
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formulas = await database.getAllFormulas()
         
         guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id else {
             print("Formulas not found")
             return
         }
         
//         let f1AcademyEvents = [
//             ("Bahrain Grand Prix", "2025-03-02", "2025-03-03"),
//             ("Saudi Arabian Grand Prix", "2025-03-09", "2025-03-10"),
//             ("Miami Grand Prix", "2025-05-04", "2025-05-05"),
//             ("Monaco Grand Prix", "2025-05-25", "2025-05-26"),
//             ("Spanish Grand Prix", "2025-06-22", "2025-06-23"),
//             ("Hungarian Grand Prix", "2025-07-20", "2025-07-21"),
//             ("Belgian Grand Prix", "2025-07-27", "2025-07-28"),
//             ("Netherlands Grand Prix", "2025-08-24", "2025-08-25"),
//             ("Qatar Grand Prix", "2025-11-30", "2025-12-01")
//         ]
         
         let f2Events = [
             ("Bahrain Grand Prix", "2025-03-01", "2025-03-03"),
             ("Saudi Arabian Grand Prix", "2025-03-08", "2025-03-10"),
             ("Australian Grand Prix", "2025-03-22", "2025-03-24"),
             ("Imola Grand Prix", "2025-05-17", "2025-05-19"),
             ("Monaco Grand Prix", "2025-05-24", "2025-05-26"),
             ("Spanish Grand Prix", "2025-06-21", "2025-06-23"),
             ("Austrian Grand Prix", "2025-06-28", "2025-06-30"),
             ("British Grand Prix", "2025-07-05", "2025-07-07"),
             ("Hungarian Grand Prix", "2025-07-19", "2025-07-21"),
             ("Belgian Grand Prix", "2025-07-26", "2025-07-28"),
             ("Netherlands Grand Prix", "2025-08-23", "2025-08-25"),
             ("Italian Grand Prix", "2025-08-30", "2025-09-01"),
             ("Azerbaijan Grand Prix", "2025-09-13", "2025-09-15"),
             ("Abu Dhabi Grand Prix", "2025-12-06", "2025-12-08")
         ]
         
//         let f3Events = [
//             ("Bahrain Grand Prix", "2025-03-01", "2025-03-03"),
//             ("Australian Grand Prix", "2025-03-22", "2025-03-24"),
//             ("Imola Grand Prix", "2025-05-17", "2025-05-19"),
//             ("Monaco Grand Prix", "2025-05-24", "2025-05-26"),
//             ("Spanish Grand Prix", "2025-06-21", "2025-06-23"),
//             ("Austrian Grand Prix", "2025-06-28", "2025-06-30"),
//             ("British Grand Prix", "2025-07-05", "2025-07-07"),
//             ("Hungarian Grand Prix", "2025-07-19", "2025-07-21"),
//             ("Belgian Grand Prix", "2025-07-26", "2025-07-28"),
//             ("Netherlands Grand Prix", "2025-08-23", "2025-08-25")
//         ]
         
//         for event in f1AcademyEvents {
//             let date = dateFormatter.date(from: event.1)
//             let startTime = dateFormatter.date(from: event.2)
//             await database.addEvent(
//                 name: event.0,
//                 date: date,
//                 startTime: startTime,
//                 idFormula: f1AcademyId
//             )
//         }
         
         for event in f2Events {
             let date = dateFormatter.date(from: event.1)
             let startTime = dateFormatter.date(from: event.2)
             await database.addEvent(
                 name: event.0,
                 date: date,
                 startTime: startTime,
                 idFormula: f2Id
             )
         }
          
//          for event in f3Events {
//             let date = dateFormatter.date(from: event.1)
//             let startTime = dateFormatter.date(from: event.2)
//             await database.addEvent(
//                 name: event.0,
//                 date: date,
//                 startTime: startTime,
//                 idFormula: f3Id
//             )
//         }
     }
    
    private func seedComponents() async {
        print("Seeding components...")
        
        let existingComponents = await database.getAllComponents()
        if !existingComponents.isEmpty {
            print("Components already exist, skipping...")
            return
        }
        
        let components = [
            ("Engine", "High-performance combustion engine", "engine_image"),
            ("Gearbox", "Seamless-shift transmission", "gearbox_image"),
            ("Chassis", "Carbon fiber monocoque chassis", "chassis_image"),
            ("Suspension", "Pushrod suspension system", "suspension_image"),
            ("Brakes", "Carbon ceramic brake discs", "brakes_image"),
            ("Aerodynamics", "Front and rear wing package", "aero_image"),
            ("Tires", "Pirelli racing slicks", "tire_image")
        ]
        for comp in components {
            await database.addComponent(name: comp.0, details: comp.1, image: comp.2)
        }
    }
    
    private func seedCars() async {
        print("Seeding cars...")
        
        let existingCars = await database.getAllCars()
        if !existingCars.isEmpty {
            print("Cars already exist, skipping...")
            return
        }
        
        let componentIds = (await database.getAllComponents()).map { $0.id }
        let formulas = await database.getAllFormulas()
        for formula in formulas {
            await database.addCar(idComponents: componentIds, idFormula: formula.id, image: nil)
        }
    }
    
    // MARK: - Debugging Methods
    
    /// Exibe o status detalhado do banco de dados
    func printDatabaseStatus() async {
        print("\n=== DATABASE STATUS ===")
        
        let formulas = await database.getAllFormulas()
        print("📊 Formulas: \(formulas.count)")
        for formula in formulas {
            print("  - \(formula.name)")
        }
        
        let scuderias = await database.getAllScuderias()
        print("🏎️ Scuderias: \(scuderias.count)")
        
        let drivers = await database.getAllDrivers()
        print("👤 Drivers: \(drivers.count)")
        
        let tracks = await database.getAllTracks()
        print("🏁 Tracks: \(tracks.count)")
        
        let glossaryTerms = await database.getAllGlossaryTerms()
        print("📖 Glossary Terms: \(glossaryTerms.count)")
        
        let rules = await database.getAllRules()
        print("📋 Rules: \(rules.count)")
        
        let events = await database.getAllEvents()
        print("📅 Events: \(events.count)")
        
        let components = await database.getAllComponents()
        print("🔧 Components: \(components.count)")
        
        let cars = await database.getAllCars()
        print("🚗 Cars: \(cars.count)")
        
        let hasSeeded = Self.isSeedCompleted()
        print("✅ Seed Status: \(hasSeeded ? "Completed" : "Not completed")")
        
        print("=====================\n")
    }
    
    /// Reseta a flag de seed no UserDefaults (útil para development)
    func resetSeedFlag() {
        Self.markSeedAsNotCompleted()
    }
    
    // MARK: - UserDefaults Keys
    static let seedCompletedKey = "hasSeededCloudKit"
    
    // MARK: - Public Status Methods
    
    /// Verifica se o seed foi completado (usado pelo SceneDelegate)
    static func isSeedCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: seedCompletedKey)
    }
    
    /// Marca o seed como completado
    static func markSeedAsCompleted() {
        UserDefaults.standard.set(true, forKey: seedCompletedKey)
        print("✅ Seed marked as completed in UserDefaults")
    }
    
    /// Marca o seed como não completado (para reset)
    static func markSeedAsNotCompleted() {
        UserDefaults.standard.set(false, forKey: seedCompletedKey)
        print("🔄 Seed marked as not completed in UserDefaults")
    }

}
