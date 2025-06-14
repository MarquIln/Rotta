//
//  DatabaseSeed.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//


import Foundation
import CoreData

extension Database {
    
    func seedDatabase() {
        print("Starting database seed...")
        
        seedFormulas()
        seedScuderias()
        seedDrivers()
        seedTracks()
        seedGlossary()
        seedRules()
        seedEvents()
        
        print("Database seed completed successfully!")
    }
    
    private func seedFormulas() {
        addNewFormula(name: "Formula 1 Academy", color: "#E10600")
        addNewFormula(name: "Formula 2", color: "#00D2BE")
        addNewFormula(name: "Formula 3", color: "#FFF500")
    }
    
    private func seedScuderias() {
        guard let f1AcademyId = getFormulaId(for: "Formula 1 Academy"),
              let f2Id = getFormulaId(for: "Formula 2"),
              let f3Id = getFormulaId(for: "Formula 3") else { return }
        
        let f1AcademyTeams = [
            ("Campos Racing", "campos_logo", 108.0),
            ("MP Motorsport", "mp_logo", 94.0),
            ("PREMA Racing", "prema_logo", 88.0),
            ("Rodin Motorsport", "rodin_logo", 34.0),
            ("ART Grand Prix", "art_logo", 5.0),
            ("Hitech TGR", "hitech_logo", 1.0)
        ]
        
        for (name, logo, points) in f1AcademyTeams {
            addNewScuderia(name: name, logo: logo, points: points, idFormula: f1AcademyId)
        }
        
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
        
        for (name, logo, points) in f2Teams {
            addNewScuderia(name: name, logo: logo, points: points, idFormula: f2Id)
        }
        
        let f3Teams = [
            ("TRIDENT", "trident_logo", 176.0),
            ("Campos Racing", "campos_logo", 130.0),
            ("MP Motorsport", "mp_logo", 126.0),
            ("Van Amersfoort Racing", "var_logo", 106.0),
            ("Rodin Motorsport", "rodin_logo", 90.0),
            ("ART Grand Prix", "art_logo", 90.0),
            ("Hitech TGR", "hitech_logo", 37.0),
            ("AIX Racing", "aix_logo", 27.0),
            ("DAMS Lucas Oil", "dams_logo", 10.0),
            ("PREMA Racing", "prema_logo", 8.0)
        ]
        
        for (name, logo, points) in f3Teams {
            addNewScuderia(name: name, logo: logo, points: points, idFormula: f3Id)
        }
    }
    
    private func getScuderiaId(name: String, formulaId: UUID) -> UUID? {
        let scuderias = getScuderiasByFormula(idFormula: formulaId)
        return scuderias.first { $0.name == name }?.id
    }
    
    private func seedDrivers() {
        guard let f1AcademyId = getFormulaId(for: "Formula 1 Academy"),
              let f2Id = getFormulaId(for: "Formula 2"),
              let f3Id = getFormulaId(for: "Formula 3") else { return }
        
        let f1AcademyDrivers = [
            ("Maya Weug", "Spain", 47, "Campos Racing", 64.0),
            ("Lia Pin", "France", 1, "MP Motorsport", 63.0),
            ("Sophia Flörsch", "Germany", 2, "PREMA Racing", 55.0),
            ("Palou Toni", "Spain", 3, "Rodin Motorsport", 44.0),
            ("Larson Kyle", "United States", 4, "MP Motorsport", 28.0),
            ("Llorca Marc", "Spain", 5, "Campos Racing", 23.0),
            ("Hauger Dennis", "Norway", 6, "Hitech TGR", 13.0),
            ("Gada Reema", "United Arab Emirates", 7, "PREMA Racing", 12.0),
            ("Felipe Drugovich", "Brazil", 8, "ART Grand Prix", 10.0),
            ("Ferris Jack", "United Kingdom", 9, "Rodin Motorsport", 9.0),
            ("Aurelia Nobels", "Belgium", 10, "ART Grand Prix", 3.0),
            ("Lia Block", "United States", 11, "Rodin Motorsport", 2.0),
            ("Caterina Ciacci", "Italy", 12, "Hitech TGR", 2.0),
            ("Ana Segura", "Mexico", 13, "Campos Racing", 1.0),
            ("Chloe Chong", "United States", 14, "Hitech TGR", 1.0)
        ]
        
        for (name, country, number, teamName, points) in f1AcademyDrivers {
            if let scuderiaId = getScuderiaId(name: teamName, formulaId: f1AcademyId) {
                addNewDriver(name: name, country: country, number: Int16(number), points: points, scuderia: scuderiaId, idFormula: f1AcademyId)
            }
        }
        
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
        
        for (name, country, number, teamName, points) in f2Drivers {
            if let scuderiaId = getScuderiaId(name: teamName, formulaId: f2Id) {
                addNewDriver(name: name, country: country, number: Int16(number), points: points, scuderia: scuderiaId, idFormula: f2Id)
            }
        }
        
        let f3Drivers = [
            ("Rafael Camara", "Brazil", 1, "Campos Racing", 105.0),
            ("Nikola Tsolov", "Bulgaria", 2, "ART Grand Prix", 79.0),
            ("Tim Tramnitz", "Germany", 3, "TRIDENT", 70.0),
            ("Charlie Wurz", "Austria", 4, "Hitech TGR", 56.0),
            ("Tuukka Taponen", "Finland", 5, "MP Motorsport", 51.0),
            ("Kacper Sztuka", "Poland", 6, "MP Motorsport", 45.0),
            ("Noel Ramzi", "Singapore", 7, "Rodin Motorsport", 45.0),
            ("Martinius Stenshorne", "Norway", 8, "Hitech TGR", 43.0),
            ("Callum Voisin", "United Kingdom", 9, "Rodin Motorsport", 41.0),
            ("Gabriel Biller", "Denmark", 10, "Campos Racing", 38.0),
            ("Laurens van Hoepen", "Netherlands", 11, "ART Grand Prix", 37.0),
            ("Mari Boya", "Spain", 12, "TRIDENT", 36.0),
            ("Sami Meguetounif", "France", 13, "Van Amersfoort Racing", 36.0),
            ("Domenico Lovera", "Italy", 14, "DAMS Lucas Oil", 18.0),
            ("Nikita Bedrin", "Italy", 15, "AIX Racing", 17.0),
            ("James Wharton", "Australia", 16, "PREMA Racing", 15.0),
            ("Tasanapol Inthraphuvasak", "Thailand", 17, "Rodin Motorsport", 15.0),
            ("Alex Dunne", "Ireland", 18, "MP Motorsport", 11.0),
            ("Max Esterson", "United States", 19, "Hitech TGR", 11.0),
            ("Ugo Ugochukwu", "United States", 20, "PREMA Racing", 10.0),
            ("Matías Zagazeta", "Peru", 21, "DAMS Lucas Oil", 6.0),
            ("Arvid Lindblad", "United Kingdom", 22, "PREMA Racing", 4.0),
            ("Leonardo Fornaroli", "Argentina", 23, "TRIDENT", 4.0),
            ("Luke Browning", "United Kingdom", 24, "Campos Racing", 3.0),
            ("James Wharton", "Australia", 25, "PREMA Racing", 0.0),
            ("William Alatalo", "Finland", 26, "Van Amersfoort Racing", 0.0),
            ("Brando Badoer", "Italy", 27, "PREMA Racing", 0.0)
        ]
        
        for (name, country, number, teamName, points) in f3Drivers {
            if let scuderiaId = getScuderiaId(name: teamName, formulaId: f3Id) {
                addNewDriver(name: name, country: country, number: Int16(number), points: points, scuderia: scuderiaId, idFormula: f3Id)
            }
        }
    }
    
    private func seedTracks() {
        guard let f1AcademyId = getFormulaId(for: "Formula 1 Academy"),
              let f2Id = getFormulaId(for: "Formula 2"),
              let f3Id = getFormulaId(for: "Formula 3") else { return }
        
        let tracks = [
            ("Bahrain International Circuit", "Sakhir, Bahrain", 5.412),
            ("Jeddah Corniche Circuit", "Jeddah, Saudi Arabia", 6.174),
            ("Albert Park Circuit", "Melbourne, Australia", 5.278),
            ("Suzuka International Racing Course", "Suzuka, Japan", 5.807),
            ("Shanghai International Circuit", "Shanghai, China", 5.451),
            ("Miami International Autodrome", "Miami, USA", 5.412),
            ("Autodromo Enzo e Dino Ferrari", "Imola, Italy", 4.909),
            ("Circuit de Monaco", "Monte Carlo, Monaco", 3.337),
            ("Circuit Gilles Villeneuve", "Montreal, Canada", 4.361),
            ("Circuit de Barcelona-Catalunya", "Barcelona, Spain", 4.675),
            ("Red Bull Ring", "Spielberg, Austria", 4.318),
            ("Silverstone Circuit", "Silverstone, UK", 5.891),
            ("Hungaroring", "Budapest, Hungary", 4.381),
            ("Circuit de Spa-Francorchamps", "Spa, Belgium", 7.004),
            ("Circuit Zandvoort", "Zandvoort, Netherlands", 4.259),
            ("Autodromo Nazionale di Monza", "Monza, Italy", 5.793),
            ("Marina Bay Street Circuit", "Singapore", 5.063),
            ("Circuit of the Americas", "Austin, USA", 5.513),
            ("Autódromo Hermanos Rodríguez", "Mexico City, Mexico", 4.304),
            ("Interlagos Circuit", "São Paulo, Brazil", 4.309),
            ("Las Vegas Strip Circuit", "Las Vegas, USA", 6.201),
            ("Losail International Circuit", "Lusail, Qatar", 5.380),
            ("Yas Marina Circuit", "Abu Dhabi, UAE", 5.281),
            ("TBA New Street Circuit", "TBA, TBA", 5.500)
        ]
        
        for (name, location, distance) in tracks {
            addNewTrack(name: name, location: location, distance: distance, idFormula: [f1AcademyId])
            addNewTrack(name: name, location: location, distance: distance, idFormula: [f2Id])
            addNewTrack(name: name, location: location, distance: distance, idFormula: [f3Id])
        }
    }
    
    private func seedGlossary() {
        let glossaryTerms = [
            ("DRS", "Drag Reduction System that reduces aerodynamic drag on cars, allowing them to achieve higher top speeds and facilitating overtaking."),
            ("Pole Position", "The first position on the starting grid, achieved by the driver who records the fastest time in the qualifying session."),
            ("Chicane", "A sequence of S-shaped corners that forces drivers to reduce speed."),
            ("Pit Stop", "A stop in the pits for tire changes, refueling, or repairs during the race."),
            ("Safety Car", "A safety car that enters the track to control the pace when there are accidents or dangerous conditions."),
            ("Undercut", "A strategy where a driver pits before their rival to gain positions with fresh tires."),
            ("Overcut", "The opposite strategy to undercut, where the driver stays on track longer before pitting."),
            ("Slipstream", "An aerodynamic effect where one car follows another very closely to reduce air resistance."),
            ("Apex", "The ideal point of a corner, usually on the inside, where the car should pass for the best trajectory."),
            ("Dirty Air", "Turbulent air created by the car in front that makes overtaking difficult."),
            ("KERS", "Kinetic Energy Recovery System that stores energy from braking for later use."),
            ("Parc Fermé", "Restricted area where cars are kept after qualifying, with specific regulations about modifications.")
        ]
        
        for (name, details) in glossaryTerms {
            addNewGlossaryTerm(name: name, details: details)
        }
    }
    
    private func seedRules() {
        guard let f1AcademyId = getFormulaId(for: "Formula 1 Academy"),
              let f2Id = getFormulaId(for: "Formula 2"),
              let f3Id = getFormulaId(for: "Formula 3") else { return }
        
        let generalRules = [
            ("Flags", "Yellow flag: danger, reduce speed. Red flag: stop immediately. Blue flag: let the faster driver pass."),
            ("Track Limits", "Drivers must keep at least two wheels within track limits in corners. Violations result in penalties."),
            ("Start", "The start will be given when all lights go out. Jump starts result in penalties."),
            ("Overtaking", "Overtaking must be done safely and sportingly, without forcing another driver off the track.")
        ]
        
        let f1AcademyRules = [
            ("DRS", "DRS can be used in designated zones when the driver is less than 1 second behind the car in front."),
            ("Points System", "Point system: 25-18-15-12-10-8-6-4-2-1 for the top 10 finishers."),
            ("Race Duration", "Races have a duration of approximately 30-40 minutes or a fixed number of laps.")
        ]
        
        let f2Rules = [
            ("Races", "Weekend with two races: Sprint Race on Saturday and Feature Race on Sunday."),
            ("Points System", "Feature Race: 25-18-15-12-10-8-6-4-2-1. Sprint Race: 15-12-10-8-6-4-2-1 points."),
            ("Tyres", "Three tire compounds available per weekend: hard, medium and soft."),
            ("DRS", "Two DRS zones per track, activation allowed after the first lap.")
        ]
        
        let f3Rules = [
            ("Format", "Three races per weekend: two Sprint Races and one Feature Race."),
            ("Feature Race Points", "25-18-15-12-10-8-6-4-2-1 for the top 10 finishers."),
            ("Sprint Race Points", "10-8-6-5-4-3-2-1 for the top 8 finishers."),
            ("Starting Grid", "Race 1 grid based on qualifying. Race 2 with reverse grid.")
        ]
        
        for (name, details) in generalRules {
            addNewRule(name: name, details: details, idFormula: f1AcademyId)
            addNewRule(name: name, details: details, idFormula: f2Id)
            addNewRule(name: name, details: details, idFormula: f3Id)
        }
        
        for (name, details) in f1AcademyRules {
            addNewRule(name: name, details: details, idFormula: f1AcademyId)
        }
        
        for (name, details) in f2Rules {
            addNewRule(name: name, details: details, idFormula: f2Id)
        }
        
        for (name, details) in f3Rules {
            addNewRule(name: name, details: details, idFormula: f3Id)
        }
    }
    
    private func seedEvents() {
        
        guard let f2Id = getFormulaId(for: "Formula 2") else {
            print("Formula 2 não encontrada")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        
        func createEvent(_ dateTimeString: String) {
            guard let dateTime = dateFormatter.date(from: dateTimeString) else {
                print("Erro ao fazer parse da data: \(dateTimeString)")
                return
            }
            addNewEvent(date: dateTime, startTime: dateTime, idFormula: f2Id)
        }
        
        createEvent("2025-02-28 11:00")
        createEvent("2025-02-28 14:30")
        createEvent("2025-03-01 16:15")
        createEvent("2025-03-02 12:15")
        
        createEvent("2025-03-07 11:30")
        createEvent("2025-03-07 15:00")
        createEvent("2025-03-08 16:45")
        createEvent("2025-03-09 13:00")
        
        createEvent("2025-03-21 11:00")
        createEvent("2025-03-21 14:30")
        createEvent("2025-03-22 16:00")
        createEvent("2025-03-23 12:30")
        
        createEvent("2025-04-04 10:30")
        createEvent("2025-04-04 14:00")
        createEvent("2025-04-05 15:30")
        createEvent("2025-04-06 12:00")
        
        createEvent("2025-04-18 11:00")
        createEvent("2025-04-18 14:30")
        createEvent("2025-04-19 16:15")
        createEvent("2025-04-20 12:45")
        
        createEvent("2025-05-02 11:30")
        createEvent("2025-05-02 15:00")
        createEvent("2025-05-03 16:30")
        createEvent("2025-05-04 13:00")
        
        createEvent("2025-05-16 10:00")
        createEvent("2025-05-16 13:30")
        createEvent("2025-05-17 15:00")
        createEvent("2025-05-18 11:30")
        
        createEvent("2025-05-23 09:30")
        createEvent("2025-05-23 13:00")
        createEvent("2025-05-24 14:30")
        createEvent("2025-05-25 10:00")
        
        createEvent("2025-06-13 11:00")
        createEvent("2025-06-13 14:30")
        createEvent("2025-06-14 16:00")
        createEvent("2025-06-15 12:30")
        
        createEvent("2025-06-27 10:30")
        createEvent("2025-06-27 14:00")
        createEvent("2025-06-28 15:30")
        createEvent("2025-06-29 11:45")
        
        createEvent("2025-07-04 11:00")
        createEvent("2025-07-04 14:30")
        createEvent("2025-07-05 16:15")
        createEvent("2025-07-06 12:00")
        
        createEvent("2025-07-25 10:30")
        createEvent("2025-07-25 14:00")
        createEvent("2025-07-26 15:45")
        createEvent("2025-07-27 12:15")
        
        createEvent("2025-08-01 11:00")
        createEvent("2025-08-01 14:30")
        createEvent("2025-08-02 16:00")
        createEvent("2025-08-03 12:30")
        
        createEvent("2025-08-29 10:30")
        createEvent("2025-08-29 14:00")
        createEvent("2025-08-30 15:30")
        createEvent("2025-08-31 11:45")
        
        createEvent("2025-09-05 11:00")
        createEvent("2025-09-05 14:30")
        createEvent("2025-09-06 16:15")
        createEvent("2025-09-07 12:00")
        
        createEvent("2025-09-19 10:30")
        createEvent("2025-09-19 14:00")
        createEvent("2025-09-20 15:45")
        createEvent("2025-09-21 12:15")
        
        createEvent("2025-10-03 19:00")
        createEvent("2025-10-03 22:30")
        createEvent("2025-10-04 20:15")
        createEvent("2025-10-05 19:30")
        
        createEvent("2025-10-17 11:30")
        createEvent("2025-10-17 15:00")
        createEvent("2025-10-18 16:30")
        createEvent("2025-10-19 13:00")
        
        createEvent("2025-10-24 12:00")
        createEvent("2025-10-24 15:30")
        createEvent("2025-10-25 17:00")
        createEvent("2025-10-26 13:30")
        
        createEvent("2025-11-07 11:00")
        createEvent("2025-11-07 14:30")
        createEvent("2025-11-08 16:00")
        createEvent("2025-11-09 12:30")
        
        createEvent("2025-11-20 22:00")
        createEvent("2025-11-21 01:30")
        createEvent("2025-11-21 23:15")
        createEvent("2025-11-22 22:00")
        
        createEvent("2025-11-28 14:00")
        createEvent("2025-11-28 17:30")
        createEvent("2025-11-29 19:00")
        createEvent("2025-11-30 15:00")
        
        createEvent("2025-12-05 13:00")
        createEvent("2025-12-05 16:30")
        createEvent("2025-12-06 18:15")
        createEvent("2025-12-07 14:00")
        
        print("Formula 2 events seeded successfully!")
    }
}
