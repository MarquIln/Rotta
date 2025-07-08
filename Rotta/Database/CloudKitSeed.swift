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
            ("F1 Academy", "#FF0000"),
//            ("Formula 2", "#0000FF"),
            ("Formula 3", "#00FF00"),
        ]
        
        for formula in formulas {
            await database.addFormula(name: formula.0, color: formula.1)
        }
    }
    
    private func seedAllScuderias() async {
        print("Seeding scuderias...")
        
        let existingScuderias = await database.getAllScuderias()
        if !existingScuderias.isEmpty {
            print("Scuderias already exist, skipping...")
            return
        }
        
        let formulas = await database.getAllFormulas()
        
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id,
              let f3Id = formulas.first(where: { $0.name == "Formula 3" })?.id,
              let f1AcademyId = formulas.first(where: { $0.name == "F1 Academy" })?.id else {
            print("Formulas not found after retries")
            return
        }
        
        let f1AcademyTeams = [
            ("Campos Racing", "campos_logo", 64.0, 250.0, "Espanha", 0, 1, 8, "Equipe espanhola que compete na F1 Academy desde 2023, com foco no desenvolvimento de pilotos femininas no automobilismo."),
            ("MP Motorsport", "mp_logo", 91.0, 350.0, "Holanda", 1, 3, 12, "Equipe holandesa tradicional no automobilismo feminino, com excelente histórico de desenvolvimento de talentos."),
            ("PREMA Racing", "prema_logo", 67.0, 400.0, "Itália", 2, 4, 15, "Equipe italiana reconhecida mundialmente por sua excelência no desenvolvimento de jovens pilotos."),
            ("Rodin Motorsport", "rodin_logo", 50.0, 150.0, "Reino Unido", 0, 2, 6, "Equipe britânica que ingressou na F1 Academy em 2024, focada no desenvolvimento de pilotos femininas."),
            ("ART Grand Prix", "art_logo", 13.0, 300.0, "França", 1, 1, 4, "Equipe francesa tradicional nas categorias de base, com ampla experiência no desenvolvimento de pilotos."),
            ("Hitech TGR", "hitech_logo", 14.0, 200.0, "Reino Unido", 0, 1, 3, "Equipe britânica que participa da F1 Academy, conhecida por sua abordagem técnica e profissional.")
        ]
        
        for team in f1AcademyTeams {
            await database.addScuderia(
                name: team.0,
                logo: team.1,
                points: team.2,
                historicPoints: Int16(team.3),
                idFormula: f1AcademyId,
                country: team.4,
                pole: Int16(team.5),
                victory: Int16(team.6),
                podium: Int16(team.7),
                details: team.8
            )
        }
        
        
        
        let f2Teams = [
            ("Campos Racing", "campos_logo", 128.0, 3500, "Espanha", 0, 3, 19, "Fundada em 1997, a equipe espanhola de automobilismo gerenciada pelo ex-piloto de Fórmula 1 Adrián Campos. Atualmente compete nos Campeonatos de Fórmula 2, Fórmula 3 e Fórmula 1 Academy. Em 1999 estreiou o atual piloto de Fórmula 1 Fernando Alonso."),
            ("Hitech TGR", "hitech_logo", 102.0, 600.0,"Reino Unido", 3, 10, 28,"Fundada em 2002, anteriormente conhecida como Hitech Racing e atualmente competindo como Hitech TGR é uma equipe britânica que atualmente compete na Fórmula 2 e Fórmula 3."),
            ("MP Motorsport", "mp_logo", 96.0, 800.0, "Holanda", 5, 11, 23, "Fundada em 1995, o time holandês competiu em diversas outras categorias além da Fórmula 2. Atualmente compete além da Fórmula 2, na Fórmula 3, Eurocup-3, Fórmula Espanhola 4 e F1 Academy."),
            ("DAMS Lucas Oil", "dams_logo", 94.0, 1000.0, "França", 8, 18, 60, "Fundada em 1988, a equipe francesa atualmente participa dos Campeonatos de Fórmula 2 e Fórmula 3. Esteve próxima de correr a temporada de 1996 da Fórmula 1 mas isso acabou por não se verificar."),
            ("Rodin Motorsport", "rodin_logo", 89.0, 100.0, "Reino Unido", 1, 2, 7, "Fundada em 1999 como Carlin Motorsport, a equipe britânica foi renomeada para Rodin Motorsport em 2024. Atualmente, compete nos Campeonatos de Fórmula 2 e Fórmula 3 além de outras categorias de base."),
            ("Invicta Racing", "invicta_logo", 78.0, 3500.0, "Reino Unido", 21, 42, 124, "Fundada como Virtuosi UK em 2012, tornou-se Russian Time e UNI-Virtuosi em 2019, Invicta Virtuosi Racing em 2023 e, por último, Invicta Racing em 2024. Na sua história, correu em diversas categorias de assento único."),
            ("PREMA Racing", "prema_logo", 57.0, 1000.0, "Itália", 15, 29, 23, "Fundada em 1983, é uma equipe italiana de automobilismo que atualmente compete nos Campeonatos de Fórmula 2 e Fórmula 3, bem como na IndyCar Series."),
            ("ART Grand Prix", "art_logo", 46.0, 1000.0, "França", 14, 22, 31, "Fundada em 1996 como ASM Formule 3 e renomeada para ART Grand Prix em 2005, a equipe francesa atualmente participa dos Campeonatos de Fórmula 2 e Fórmula 3."),
            ("AIX Racing", "aix_logo", 11.0, 100.0, "Emirados Árabes Unidos / Alemanha", 0, 3, 5, "Fundada em 2024, a equipe Emirado-Alemã AIX Racing participa atualmente dos Campeonatos de Fórmula 2 e Fórmula 3 da FIA. A equipe surgiu a partir da aquisição das operações de Fórmula 2 e Fórmula 3 da PHM Racing pela AIX Investment Group."),
            ("Van Amersfoort Racing", "var_logo", 10.0, 200.0, "Holanda", 0, 2, 5, "Fundada em 1975, a equipe holandesa Van Amersfoort Racing (VAR) ingressou na Fórmula 2 da FIA em 2022. Atualmente, compete nos Campeonatos de Fórmula 2 e Fórmula 3, além de outras categorias de base."),
            ("TRIDENT", "trident_logo", 1.0, 200.0, "Itália", 0, 1, 5, "Fundada em 2006, a equipe italiana Trident Motorsport atualmente participa dos Campeonatos de Fórmula 2 e Fórmula 3.")
        ]
        
        for team in f2Teams {
            await database.addScuderia(
                name: team.0,
                logo: team.1,
                points: team.2,
                historicPoints: Int16(team.3),
                idFormula: f2Id,
                country: team.4,
                pole: Int16(team.5),
                victory: Int16(team.6),
                podium: Int16(team.7),
                details: team.8
            )
        }
        
        let f3Teams = [
            ("TRIDENT", "trident_logo", 176.0, 800.0, "Itália", 8, 15, 45, "Equipe italiana tradicional na Fórmula 3, com vasta experiência no desenvolvimento de pilotos jovens."),
            ("Campos Racing", "campos_logo", 130.0, 600.0, "Espanha", 5, 12, 35, "Equipe espanhola com sólida tradição nas categorias de base do automobilismo mundial."),
            ("MP Motorsport", "mp_logo", 126.0, 700.0, "Holanda", 6, 11, 38, "Equipe holandesa reconhecida por sua consistência e excelência técnica na Fórmula 3."),
            ("Van Amersfoort Racing", "var_logo", 106.0, 500.0, "Holanda", 3, 8, 25, "Equipe holandesa tradicional com ampla experiência no desenvolvimento de jovens talentos."),
            ("Rodin Motorsport", "rodin_logo", 90.0, 300.0, "Reino Unido", 2, 6, 18, "Equipe britânica que compete na Fórmula 3 com foco no desenvolvimento técnico e esportivo."),
            ("ART Grand Prix", "art_logo", 90.0, 900.0, "França", 10, 18, 55, "Equipe francesa de grande tradição nas categorias de base, com excelente histórico de títulos."),
            ("Hitech TGR", "hitech_logo", 37.0, 400.0, "Reino Unido", 1, 4, 12, "Equipe britânica conhecida por sua abordagem técnica e profissional na Fórmula 3."),
            ("AIX Racing", "aix_logo", 27.0, 100.0, "Emirados Árabes Unidos", 0, 2, 6, "Equipe recente na Fórmula 3, buscando estabelecer-se como uma força competitiva."),
            ("DAMS Lucas Oil", "dams_logo", 10.0, 200.0, "França", 1, 1, 8, "Equipe francesa tradicional que compete na Fórmula 3 com foco no desenvolvimento de pilotos."),
            ("PREMA Racing", "prema_logo", 8.0, 1500.0, "Itália", 25, 35, 80, "Equipe italiana de elite, múltipla campeã mundial nas categorias de base do automobilismo.")
        ]
        
        for team in f3Teams {
            await database.addScuderia(
                name: team.0,
                logo: team.1,
                points: team.2,
                historicPoints: Int16(team.3),
                idFormula: f3Id,
                country: team.4,
                pole: Int16(team.5),
                victory: Int16(team.6),
                podium: Int16(team.7),
                details: team.8
            )
        }
    }
    
    private func seedAllDrivers() async {
        print("Seeding drivers...")
        
        let existingDrivers = await database.getAllDrivers()
        if !existingDrivers.isEmpty {
            print("Drivers already exist, skipping...")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formulas = await database.getAllFormulas()
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id,
              let f3Id = formulas.first(where: { $0.name == "Formula 3" })?.id,
              let f1AcademyId = formulas.first(where: { $0.name == "F1 Academy" })?.id else {
            print("Formulas not found")
            return
        }
        
        let f1AcademyDrivers = [
            ("Maya Weug", "Spain", 47, 64, "Campos Racing", "1.65", "2004-03-18", "Karting World Championship U18 - 2019", "Primeira mulher a vencer uma corrida da Ferrari Driver Academy. Campeã mundial de kart em 2019, Maya é uma das pilotos mais promissoras da F1 Academy."),
            ("Lia Pin", "France", 1, 63, "MP Motorsport", "1.68", "2005-02-14", "French F4 Championship - 2022", "Piloto francesa com excelente histórico no kart e na F4 francesa. Conhecida por sua velocidade e determinação nas pistas."),
            ("Sophia Flörsch", "Germany", 2, 55, "PREMA Racing", "1.70", "2000-12-01", "ADAC F4 Championship - 2016", "Piloto alemã experiente com passagem por várias categorias internacionais. Conhecida por sua resiliência e velocidade."),
            ("Palou Toni", "Spain", 3, 44, "Rodin Motorsport", "1.72", "2004-08-22", "Spanish F4 Championship - 2021", "Jovem piloto espanhol com grande potencial, destacando-se nas categorias de base do automobilismo."),
            ("Larson Kyle", "United States", 4, 28, "MP Motorsport", "1.75", "2005-05-10", "US F4 Championship - 2022", "Piloto americano com sólida formação no automobilismo nacional dos EUA, buscando projeção internacional."),
            ("Llorca Marc", "Spain", 5, 23, "Campos Racing", "1.71", "2004-11-30", "Spanish F4 Championship - 2022", "Piloto espanhol em ascensão, com bons resultados nas categorias de base na Espanha."),
            ("Hauger Dennis", "Norway", 6, 13, "Hitech TGR", "1.78", "2003-03-17", "ADAC F4 Championship - 2019", "Piloto norueguês com experiência internacional, ex-campeão de F4 e com passagem pela F3."),
            ("Gada Reema", "United Arab Emirates", 7, 12, "PREMA Racing", "1.67", "2006-01-25", "UAE Karting Championship - 2020", "Piloto dos Emirados Árabes Unidos, primeira mulher de seu país a competir em categorias internacionais de monopostos."),
            ("Felipe Drugovich", "Brazil", 8, 10, "ART Grand Prix", "1.80", "2000-05-23", "Formula 2 Championship - 2022", "Ex-campeão da Fórmula 2 em 2022, piloto brasileiro com vasta experiência internacional."),
            ("Ferris Jack", "United Kingdom", 9, 9, "Rodin Motorsport", "1.76", "2004-09-12", "British F4 Championship - 2021", "Piloto britânico jovem com bons resultados nas categorias de base do Reino Unido."),
            ("Aurelia Nobels", "Belgium", 10, 3, "ART Grand Prix", "1.69", "2005-07-18", "Belgian F4 Championship - 2022", "Piloto belga em desenvolvimento, com potencial para crescer na F1 Academy."),
            ("Lia Block", "United States", 11, 2, "Rodin Motorsport", "1.73", "2006-04-05", "US Karting Championship - 2021", "Jovem piloto americana com background no kart e nas categorias de base dos EUA."),
            ("Caterina Ciacci", "Italy", 12, 2, "Hitech TGR", "1.66", "2005-10-28", "Italian F4 Championship - 2023", "Piloto italiana promissora, com bons resultados nas categorias de base da Itália."),
            ("Ana Segura", "Mexico", 13, 1, "Campos Racing", "1.64", "2006-06-15", "Mexican F4 Championship - 2023", "Piloto mexicana representando seu país na F1 Academy, com sólida formação no automobilismo nacional."),
            ("Chloe Chong", "United States", 14, 1, "Hitech TGR", "1.68", "2005-12-03", "US F4 Championship - 2023", "Jovem piloto americana com potencial para crescer na F1 Academy e alcançar categorias superiores.")
        ]
        
        func imageName(for fullName: String) -> String {
            return fullName
                .lowercased()
                .replacingOccurrences(of: " ", with: "_")
                .replacingOccurrences(of: "í", with: "i")
                .replacingOccurrences(of: "é", with: "e")
                .replacingOccurrences(of: "ã", with: "a")
                .replacingOccurrences(of: "ó", with: "o")
                .replacingOccurrences(of: "ç", with: "c")
        }
        
        for driver in f1AcademyDrivers {
            let date = dateFormatter.date(from: driver.6) ?? Date()
            let driverImage = imageName(for: driver.0)
            let scuderiaImage = imageName(for: driver.4)
            await database.addDriver(
                name: driver.0,
                country: driver.1,
                number: Int16(driver.2),
                points: Int16(driver.3),
                scuderia: driver.4,
                idFormula: f1AcademyId,
                photo: driverImage,
                scuderiaLogo: scuderiaImage,
                height: driver.5,
                birthDate: date,
                championship: driver.7,
                details: driver.8
            )
        }
        
        let f2Drivers = [
            ("Leonardo Fornaroli", "Argentina", 1, 66, "Invicta Racing", "1.80", "2004-12-03", "Campeonato de Fórmula 3 da FIA - 2024", "Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport."),
            ("Roman Stanek", "Czech Republic", 2, 12, "Invicta Racing", "1.78", "2004-02-25", "ADAC Formula 4 Rookie Championship de 2019", "Campeão da categoria de novatos na ADAC Formula 4 em 2019, com três vitórias e nove pódios. Em 2022 terminou em 5º lugar na FIA Fórmula 3 com a Trident, vencendo uma corrida e conquistando uma pole. Subiu para a Fórmula 2 em 2023 com a Trident, registrou sua primeira vitória na Corrida Sprint de Melbourne em 2024, e em 2025 está na Invicta Racing ao lado de Leonardo Fornaroli."),
            ("Josep Maria Martí", "Spain", 3, 49, "Campos Racing", "1.85", "2005-06-13", "Campeão Rookie na Fórmula Regional Asiática em 2022", "Campeão da categoria de novatos na F4 Española em 2021, com duas vitórias, nove pódios e três poles; em 2022 vice-campeão da Fórmula Regional Asiática; em 2023 obteve três vitórias e quatro pódios na FIA F3, terminando em 5º; em 2024 estreou na Fórmula 2 com a Campos Racing, somando uma vitória em Abu Dhabi e quatro pódios, e continuará na F2 em 2025."),
            ("Arvid Lindblad", "United Kingdom", 4, 79, "Campos Racing", "1.85", "2007-08-08", "Formula Regional Oceania Championship de 2025", "Campeão da Fórmula Regional Oceania em 2025 com a M2 Competition; foi campeão do WSK Super Master Series OK‑J e das WSK Euro Series no kart; em 2023 conquistou a Macau F4 World Cup; em 2024 foi estreante de destaque na FIA F3, vencendo quatro corridas e ficando em 4º no geral, além de levar o prêmio Aramco Best Rookie; em 2025 subiu à Fórmula 2 com a Campos Racing."),
            ("Oliver Goethe", "Germany", 5, 12, "MP Motorsport", "1.73", "2004-10-14", "Euroformula Open Championship de 2022", "Campeão da Euroformula Open em 2022 com a equipe Motopark, vencendo 11 das 26 corridas da temporada e garantindo o título com vitória em Barcelona. Em 2023, conquistou sua primeira vitória na FIA Fórmula 3 no circuito de Silverstone e também marcou pódios importantes, incluindo em Macau, em 2024."),
            ("Richard Verschoor", "Netherlands", 6, 84, "MP Motorsport", "1.87", "2000-12-16", "Campeonato Espanhol de F4 de 2016", "Campeão da F4 Spanish Championship em 2016, Richard Verschoor iniciou sua carreira com grandes resultados, conquistando várias vitórias e pódios. Desde então, progrediu pelas categorias de base até chegar à Fórmula 2, onde compete desde 2022, acumulando pódios e vitórias em corridas."),
            ("Luke Browning", "United Kingdom", 7, 73, "Hitech TGR", "1.79", "2002-01-31", "GB3 Championship de 2021", "Campeão do GB3 Championship em 2021, Luke Browning se destacou com múltiplas vitórias e pódios durante a temporada. Desde então, tem progredido nas categorias de base do automobilismo, competindo em campeonatos como a Fórmula 3 e Fórmula 2, demonstrando grande potencial."),
            ("Dino Beganovic", "Sweden", 8, 29, "Hitech TGR", "1.83", "2004-01-19", "Fórmula Regional European Championship de 2021", "Campeão do Fórmula Regional European Championship em 2021, Dino Beganovic conquistou várias vitórias e pódios ao longo da temporada. Desde então, tem evoluído nas categorias de base, competindo na FIA Fórmula 3 e seguindo para níveis mais altos do automobilismo."),
            ("Sebastián Montoya", "Colombia", 9, 36, "PREMA Racing", "1.80", "2005-04-11", "Fórmula Regional European Championship de 2022", "Campeão do Fórmula Regional European Championship em 2022, Sebastián Montoya se destacou com diversas vitórias e pódios na temporada. Desde então, tem avançado para categorias superiores, competindo na FIA Fórmula 3 e mostrando grande potencial para o futuro."),
            ("Gabriele Minì", "Italy", 10, 21, "PREMA Racing", "1.70", "2005-03-20", "Campeonato Italiano de F4 de 2019", "Campeão do F4 Italian Championship em 2019, Gabriele Minì teve uma temporada dominante com várias vitórias e pódios. Após esse sucesso, avançou para categorias superiores como a FIA Fórmula 3, continuando a desenvolver seu talento no automobilismo."),
            ("Jak Crawford", "United States", 11, 73, "DAMS Lucas Oil", "1.82", "2005-05-02", "ADAC Formula 4 Championship de 2021", "Campeão do ADAC Formula 4 Championship em 2021, Jak Crawford se destacou por sua velocidade e consistência, conquistando várias vitórias e pódios durante a temporada. Desde então, tem avançado nas categorias de base do automobilismo, competindo na FIA Fórmula 3 e buscando novos desafios."),
            ("Kush Maini", "India", 12, 21, "Dams Lucas Oil", "1.71", "2000-09-22", "Fórmula Regional Asian Championship de 2020", "Campeão da Fórmula Regional Asian Championship em 2020, Kush Maini teve uma temporada sólida com várias vitórias e pódios. Desde então, ele tem competido em categorias como a FIA Fórmula 3, mostrando grande potencial e consistência em sua carreira no automobilismo."),
            ("Victor Martins", "France", 14, 41, "ART Grand Prix", "1.73", "2001-06-16", "FIA Fórmula 3 de 2022", "Campeão da FIA Fórmula 3 em 2022 com a ART Grand Prix, Victor Martins conquistou o título após uma disputa acirrada na última rodada em Monza. Com uma performance sólida durante toda a temporada, ele garantiu o campeonato mesmo após uma penalização de 5 segundos na corrida final. Desde então, Martins avançou para a Fórmula 2, onde compete com a ART Grand Prix, buscando consolidar sua carreira no automobilismo."),
            ("Ritomo Miyata", "Japan", 15, 5, "ART Grand Prix", "1.71", "1999-08-10", "Super Formula Championship de 2023", "Campeão da Super Formula em 2023 com a TOM'S, Ritomo Miyata teve uma temporada dominante no Japão, conquistando várias vitórias e pódios. Também foi campeão da Super GT (classe GT500) em 2022, mostrando grande versatilidade. Em 2024, estreou na Europa, participando de eventos do World Endurance Championship e testes na Fórmula 2, buscando ampliar sua carreira internacional."),
            ("Amaury Cordeel", "Belgium", 16, 2, "Rodin Motorsport", "1.74", "2002-07-09", "Campeonato Espanhol de F4 de 2018", "Amaury Cordeel construiu sua carreira competindo em categorias como a Fórmula 4 Espanhola, onde obteve vitórias e pódios, além de disputar a Fórmula 3 e a Fórmula 2. Conhecido por sua consistência e velocidade, continua em evolução na Fórmula 2, buscando conquistar seu primeiro título em nível internacional."),
            ("Alexander Dunne", "Ireland", 17, 87, "Rodin Motorsport", "1.81", "2005-11-11", "Campeonato Britânico de F4 de 2022.", "Campeão dominante do Campeonato Britânico de F4 em 2022, Alexander Dunne venceu a temporada com grande vantagem, acumulando várias vitórias e pódios. No mesmo ano, também foi vice-campeão na F4 Italiana. Desde então, continua sua trajetória nas categorias de base do automobilismo europeu, consolidando-se como um dos jovens talentos mais promissores."),
            ("Joshua Dürksen", "Paraguay", 20, 11, "AIX Racing", "1.75", "2003-10-27", "Não possui vitórias em campeonatos de monopostos", "Joshua Dürksen acumulou vitórias e pódios em categorias como a Fórmula 4 Italiana e Alemã, mostrando velocidade e consistência. Segue competindo em categorias de base, como a Fórmula 3 e Fórmula 2, buscando seu primeiro grande título internacional."),
            ("Cian Shields", "United Kingdom", 21, 0, "AIX Racing", "1.85", "2005-03-07", "IAME Series Benelux – X30 Junior de 2019", "Campeão da IAME Series Benelux na categoria X30 Junior em 2019, Cian Shields iniciou sua trajetória nos monopostos em 2022, competindo no GB3 Championship pela Hitech Grand Prix, onde conquistou uma vitória e dois pódios. Em 2023, foi vice-campeão da Euroformula Open pela Motopark, com quatro vitórias e dez pódios. Em 2024, estreou na FIA Fórmula 3 com a Hitech Pulse-Eight e participou das duas últimas rodadas da Fórmula 2 pela AIX Racing. Em 2025, disputa sua primeira temporada completa na Fórmula 2 com a AIX Racing."),
            ("Sami Meguetounif", "France", 22, 1, "TRIDENT", "1.83", "2004-05-24", "Campeonato Francês de Kart na categoria Nacional (2017)", "Campeão francês de kart na categoria Nacional em 2017, Sami Meguetounif iniciou sua carreira nos monopostos em 2019. Em 2024, destacou-se na FIA Fórmula 3 com a Trident, conquistando vitórias nas corridas principais de Imola e Monza, encerrando a temporada em oitavo lugar no campeonato. Em 2025, avançou para a Fórmula 2, mantendo-se na equipe Trident, onde busca consolidar sua trajetória no automobilismo internacional."),
            ("Max Esterson", "United States", 23, 0, "TRIDENT", "1.82", "2002-10-09", "Fórmula Ford Festival de 2022", "Campeão do Fórmula Ford Festival em 2022, primeiro americano a conquistar esse título. Desde então, avançou para a FIA Fórmula 3 e estreou na Fórmula 2 com a Trident."),
            ("John Bennett", "United Kingdom", 24, 0, "Van Amersfoort Racing", "1.82", "2003-09-15", "Não possui vitórias em campeonatos de monopostos", "Vice-campeão do GB3 Championship em 2024. Estreou na Fórmula 2 no fim de 2024 e foi confirmado para temporada completa em 2025."),
            ("Rafael Villagómez", "Mexico", 25, 10, "Van Amersfoort Racing", "1.68", "2001-11-10", "Não possui vitórias em campeonatos de monopostos", "Piloto mexicano que estreou na Fórmula 2 em 2024 com a Van Amersfoort Racing. Competiu em F4, Euroformula e FIA Fórmula 3 antes de subir para a F2."),
        ]
        
        for driver in f2Drivers {
            let date = dateFormatter.date(from: driver.6) ?? Date()
                let driverImage = imageName(for: driver.0)
                let scuderiaImage = imageName(for: driver.4)
                await database.addDriver(
                    name: driver.0,
                    country: driver.1,
                    number: Int16(driver.2),
                    points: Int16(driver.3),
                    scuderia: driver.4,
                    idFormula: f2Id,
                    photo: driverImage,
                    scuderiaLogo: scuderiaImage,
                    height: driver.5,
                    birthDate: date,
                    championship: driver.7,
                    details: driver.8
                )
            
        }
        
        let f3Drivers = [
            ("Brando Badoer", "Italy", 1, 105, "PREMA Racing", "1.74", "2006-01-18", "Italian F4 Championship - 2023", "Piloto italiano filho do ex-F1 Luca Badoer, com pedigree no automobilismo e grande potencial na F3."),
            ("Noel León", "Spain", 2, 95, "PREMA Racing", "1.76", "2006-02-14", "Spanish F4 Championship - 2023", "Piloto espanhol promissor com sólida formação nas categorias de base espanholas."),
            ("Ugo Ugochukwu", "United States", 3, 88, "PREMA Racing", "1.70", "2007-03-23", "US F4 Championship - 2023", "Jovem piloto americano com grande potencial, um dos mais jovens e promissores da F3."),
            
            ("Tim Tramnitz", "Germany", 4, 82, "TRIDENT", "1.82", "2005-06-08", "German F4 Championship - 2022", "Piloto alemão experiente com sólida formação nas categorias de base alemãs."),
            ("Mari Boya", "Spain", 5, 75, "TRIDENT", "1.78", "2005-09-28", "Spanish F4 Championship - 2022", "Piloto espanhol promissor com bons resultados nas categorias nacionais."),
            ("Leonardo Fornaroli", "Argentina", 6, 68, "TRIDENT", "1.80", "2004-12-03", "Argentine F4 Championship - 2021", "Piloto argentino experiente, representando a América do Sul na F3."),
            
            ("Nikola Tsolov", "Bulgaria", 7, 79, "ART Grand Prix", "1.77", "2005-11-20", "Bulgarian Karting Championship - 2020", "Piloto búlgaro talentoso, primeiro de seu país a competir na F3 com resultados consistentes."),
            ("Laurens van Hoepen", "Netherlands", 8, 65, "ART Grand Prix", "1.83", "2005-05-17", "Dutch F4 Championship - 2022", "Piloto holandês com sólida formação nas categorias de base da Holanda."),
            ("Sami Meguetounif", "France", 9, 58, "ART Grand Prix", "1.83", "2004-05-24", "French F4 Championship - 2021", "Piloto francês experiente com passagem por várias categorias europeias."),
            
            ("Charlie Wurz", "Austria", 10, 62, "Hitech TGR", "1.78", "2005-04-22", "Austrian F4 Championship - 2022", "Piloto austríaco filho do ex-F1 Alexander Wurz, com excelente pedigree no automobilismo."),
            ("Martinius Stenshorne", "Norway", 11, 55, "Hitech TGR", "1.80", "2005-02-25", "Norwegian F4 Championship - 2022", "Piloto norueguês com grande potencial, destacando-se nas categorias de base."),
            ("Max Esterson", "United States", 12, 48, "Hitech TGR", "1.82", "2002-10-09", "US F4 Championship - 2020", "Piloto americano experiente com sólida formação no automobilismo dos EUA."),
            
            ("Tuukka Taponen", "Finland", 13, 51, "MP Motorsport", "1.79", "2005-09-12", "Finnish F4 Championship - 2022", "Piloto finlandês com tradição familiar no automobilismo, mostrando grande velocidade."),
            ("Kacper Sztuka", "Poland", 14, 45, "MP Motorsport", "1.81", "2005-08-30", "Polish F4 Championship - 2022", "Piloto polonês em ascensão, representando seu país na F3 com bons resultados."),
            ("Alex Dunne", "Ireland", 15, 42, "MP Motorsport", "1.81", "2005-11-11", "Irish F4 Championship - 2022", "Piloto irlandês irmão de Alexander Dunne, com talento natural para o automobilismo."),
            
            ("Rafael Camara", "Brazil", 16, 58, "Campos Racing", "1.75", "2006-03-15", "Brazilian F4 Championship - 2023", "Piloto brasileiro promissor, campeão da F4 brasileira e com grande potencial para o futuro."),
            ("Gabriel Biller", "Denmark", 17, 38, "Campos Racing", "1.74", "2005-10-03", "Danish F4 Championship - 2022", "Piloto dinamarquês em desenvolvimento, representando seu país na F3."),
            ("Luke Browning", "United Kingdom", 18, 35, "Campos Racing", "1.79", "2002-01-31", "British F4 Championship - 2020", "Piloto britânico experiente com sólida formação nas categorias de base."),
            
            ("Noel Ramzi", "Singapore", 19, 45, "Rodin Motorsport", "1.73", "2005-12-18", "Asian F4 Championship - 2023", "Piloto de Singapura com sólida formação nas categorias asiáticas."),
            ("Callum Voisin", "United Kingdom", 20, 41, "Rodin Motorsport", "1.76", "2005-07-14", "British F4 Championship - 2022", "Piloto britânico jovem e promissor, com bons resultados nas categorias de base."),
            ("Tasanapol Inthraphuvasak", "Thailand", 21, 28, "Rodin Motorsport", "1.69", "2005-12-28", "Thai F4 Championship - 2022", "Piloto tailandês pioneiro, primeiro de seu país a competir na F3."),
            
            ("William Alatalo", "Finland", 22, 32, "Van Amersfoort Racing", "1.77", "2005-04-12", "Finnish F4 Championship - 2023", "Piloto finlandês jovem em desenvolvimento na F3."),
            ("Arvid Lindblad", "United Kingdom", 23, 29, "Van Amersfoort Racing", "1.85", "2007-08-08", "British F4 Championship - 2023", "Piloto britânico jovem e muito promissor, com grande potencial."),
            ("Joshua Dufek", "Austria", 24, 18, "Van Amersfoort Racing", "1.78", "2005-06-25", "Austrian F4 Championship - 2023", "Piloto austríaco jovem com potencial para crescer na F3."),
            
            ("Domenico Lovera", "Italy", 25, 24, "DAMS Lucas Oil", "1.77", "2005-11-11", "Italian F4 Championship - 2022", "Piloto italiano em desenvolvimento nas categorias de base."),
            ("Matías Zagazeta", "Peru", 26, 15, "DAMS Lucas Oil", "1.76", "2005-06-19", "Peruvian F4 Championship - 2022", "Piloto peruano pioneiro, representando a América do Sul na F3."),
            ("Sebastian Montoya", "Colombia", 27, 12, "DAMS Lucas Oil", "1.78", "2005-04-11", "Colombian F4 Championship - 2022", "Piloto colombiano filho do ex-F1 Juan Pablo Montoya, com pedigree no automobilismo."),
            
            ("Nikita Bedrin", "Italy", 28, 20, "AIX Racing", "1.75", "2005-08-15", "Italian F4 Championship - 2023", "Piloto italiano jovem com potencial para crescer na F3."),
            ("James Wharton", "Australia", 29, 16, "AIX Racing", "1.81", "2005-03-07", "Australian F4 Championship - 2022", "Piloto australiano promissor, representando a Oceania na F3."),
            ("Sophia Flörsch", "Germany", 30, 8, "AIX Racing", "1.70", "2000-12-01", "German F4 Championship - 2016", "Piloto alemã experiente com passagem por várias categorias internacionais, pioneira na F3.")
        ]
        
        for driver in f3Drivers {
            let date = dateFormatter.date(from: driver.6) ?? Date()
            let driverImage = imageName(for: driver.0)
            let scuderiaImage = imageName(for: driver.4)
            await database.addDriver(
                name: driver.0,
                country: driver.1,
                number: Int16(driver.2),
                points: Int16(driver.3),
                scuderia: driver.4,
                idFormula: f3Id,
                photo: driverImage,
                scuderiaLogo: scuderiaImage,
                height: driver.5,
                birthDate: date,
                championship: driver.7,
                details: driver.8
            )
        }
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
        
        let glossaryTerms = [
            ("Drag Reduction System (DRS)", "Sistema de Redução de Arrasto", "Uma aba móvel na asa traseira que reduz o arrasto e aumenta a velocidade em linha reta.", "drs_image"),
            ("Energy Recovery System (ERS)", "Sistema de Recuperação de Energia", "Um sistema que recupera energia da frenagem e do calor do escapamento para fornecer potência extra.", "ers_image"),
            ("Pole Position", "Posição de Largada", "A primeira posição no grid de largada, concedida ao piloto mais rápido na classificação.", "polePosition_image"),
            ("Fastest Lap", "Volta Mais Rápida", "O tempo de volta mais rápido registrado durante uma corrida, muitas vezes recompensado com um ponto extra no campeonato.", "fastestLap_image"),
            ("Did Not Finish (DNF)", "Não Completou", "Quando um piloto não consegue completar a corrida devido a falha mecânica, acidente ou outros problemas.", "dnf_image"),
            ("Did Not Started (DNS)", "Não Largou", "Quando um piloto não consegue iniciar a corrida.", "dns_image"),
            ("Disqualified (DSQ)", "Desclassificado", "Quando um piloto é excluído dos resultados da corrida por violar regras.", "dsq_image"),
            ("Safety Car (SC)", "Carro de Segurança", "Um carro enviado à pista para reduzir a velocidade do pelotão em condições perigosas.", "safetyCar_image"),
            ("Virtual Safety Car (VSC)", "Carro Virtual de Segurança", "Um sistema eletrônico que limita a velocidade dos pilotos durante períodos de advertência.", "virtualSafetyCar_image"),
            ("Pit Stop", "Parada nos Boxes", "Uma parada planejada no pit lane para troca de pneus, reabastecimento ou reparos.", "pitStop_image"),
            ("Undercut", "Undercut", "Ganhar posição na pista parando antes de um rival e usando pneus novos.", "undercut_image"),
            ("Overcut", "Overcut", "Ficar mais tempo na pista do que os rivais para ganhar posição através da estratégia de pneus.", "overcut_image"),
            ("Slipstream", "Efeito Esteira", "Andar muito próximo de outro carro para reduzir a resistência do ar e aumentar a velocidade.", "slipstream_image"),
            ("Dirty Air", "Ar Sujo", "Fluxo de ar turbulento atrás de um carro que reduz a pressão aerodinâmica dos veículos que vêm atrás.", "dirtyAir_image"),
            ("Apex", "Vértice", "O ponto mais interno de uma curva onde os pilotos procuram posicionar o carro.", "apex_image"),
            ("Chicane", "Chicane", "Uma sequência de curvas fechadas projetadas para reduzir a velocidade dos carros.", "chicane_image"),
            ("Kerb", "Zebra", "Faixas elevadas ou pintadas que marcam o limite da pista.", "kerb_image"),
            ("Marshals", "Comissários", "Voluntários que garantem a segurança e fazem cumprir as regras durante os eventos de corrida.", "marshals_image"),
            ("Parc Fermé", "Parc Fermé", "Regras que limitam as modificações no carro entre a classificação e a corrida.", "parcFerme_image"),
            ("Formation Lap", "Volta de Formação", "Uma volta realizada antes da largada para aquecer os pneus e verificar as condições.", "formationLap_image")
        ]

        for term in glossaryTerms {
            await database.addGlossaryTerm(
                title: term.0,
                details: term.2,
                subtitle: term.1,
                image: term.3
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
        
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id,
              let f3Id = formulas.first(where: { $0.name == "Formula 3" })?.id,
              let f1AcademyId = formulas.first(where: { $0.name == "F1 Academy" })?.id else {
            print("Formulas not found")
            return
        }
        
        let f1AcademyRules = [
            ("Race Weekend Format", "Each weekend consists of one practice session, one qualifying session, and two races."),
            ("Points System", "Points awarded to the top 10 finishers in each race, with 25 points for the winner."),
            ("Car Specifications", "All drivers use identical Tatuus T-318 Formula 4 cars with Autotecnica engines."),
            ("Driver Eligibility", "Championship exclusively for female drivers aged 16 and above."),
            ("Tire Regulations", "All drivers must use the same tire compound provided by Pirelli."),
            ("Fuel Regulations", "All cars carry standardized fuel loads with no refueling during races."),
            ("Safety Equipment", "Drivers must wear approved helmets, HANS devices, and fire-resistant suits."),
            ("Race Duration", "Races run for 30 minutes plus one additional lap after time expires.")
        ]
        
        for rule in f1AcademyRules {
            await database.addRule(
                name: rule.0,
                details: rule.1,
                idFormula: f1AcademyId
            )
        }
        
        let f2Rules = [
            ("Race Weekend Format", "Each weekend includes practice, qualifying, one Corrida Sprint, and one feature race."),
            ("Points System", "Different points systems for feature races (25 for winner) and Corrida Sprints (15 for winner)."),
            ("Car Specifications", "All teams use identical Dallara F2 2018 chassis with Mecachrome V6 engines."),
            ("DRS Usage", "Drivers can use DRS in designated zones when within 1 second of the car ahead."),
            ("Tire Regulations", "Pirelli provides soft, medium, and hard compounds. Drivers must use two diferentes compounds in feature races."),
            ("Fuel Regulations", "No refueling allowed durante races. Cars start with enough fuel for the entire race."),
            ("Reverse Grid", "Corrida Sprint grid is determined by reverse order of top 8 from qualifying."),
            ("Feature Race Duration", "Feature races run for approximately 45 minutes plus one additional lap."),
            ("Corrida Sprint Duration", "Corrida Sprints run for aproximadamente 25 minutes plus one additional lap."),
            ("Mandatory Pit Stop", "Drivers must make at least one pit stop during feature races.")
        ]
        
        for rule in f2Rules {
            await database.addRule(
                name: rule.0,
                details: rule.1,
                idFormula: f2Id
            )
        }
        
        let f3Rules = [
            ("Race Weekend Format", "Each weekend consists of one practice session, one qualifying session, and two races."),
            ("Points System", "Points awarded to the top 10 finishers in each race, with 25 points for the winner."),
            ("Car Specifications", "All teams use identical Dallara F3 2019 chassis with Mecachrome 3.4L V6 engines."),
            ("DRS Usage", "Drivers can use DRS in designated zones when within 1 second of the car ahead."),
            ("Tire Regulations", "Pirelli provides one tire compound per weekend. All drivers must use the same compound."),
            ("Fuel Regulations", "No refueling allowed during races. Cars start with enough fuel for the entire race."),
            ("Reverse Grid", "Race 2 grid is determined by reverse order of top 8 from Race 1 results."),
            ("Race Duration", "Both races run for approximately 40 minutes plus one additional lap."),
            ("Age Restrictions", "Drivers must be at least 16 years old to compete in the championship."),
            ("Engine Allocation", "Teams are allocated a specific number of engines per season to control costs.")
        ]
        
        for rule in f3Rules {
            await database.addRule(
                name: rule.0,
                details: rule.1,
                idFormula: f3Id
            )
        }
    }
    
    private func seedEvents() async {
        print("Seeding events...")
        
//        let existingEvents = await database.getAllEvents()
//        if !existingEvents.isEmpty {
//            print("Events already exist, skipping...")
//            return
//        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let formulas = await database.getAllFormulas()
        
        guard let f2Id = formulas.first(where: { $0.name == "Formula 2" })?.id,
              let f3Id = formulas.first(where: { $0.name == "Formula 3" })?.id,
              let f1AcademyId = formulas.first(where: { $0.name == "F1 Academy" })?.id else {
            print("Formulas not found")
            return
        }
        
        let f1AcademyEvents = [
            // Bahrain GP (round 1)
            (1, "Bahrain", "Treino Livre", "2025-03-02", "10:30", "11:00"),
            (1, "Bahrain", "Classificação", "2025-03-02", "15:00", "15:30"),
            (1, "Bahrain", "Corrida 1", "2025-03-03", "12:00", "12:30"),
            
            // Saudi Arabian GP (round 2)
            (2, "Arábia Saudita", "Treino Livre", "2025-03-09", "12:30", "13:00"),
            (2, "Arábia Saudita", "Classificação", "2025-03-09", "17:00", "17:30"),
            (2, "Arábia Saudita", "Corrida 1", "2025-03-10", "14:00", "14:30"),
            
            // Miami GP (round 3)
            (3, "Estados Unidos", "Treino Livre", "2025-05-04", "16:30", "17:00"),
            (3, "Estados Unidos", "Classificação", "2025-05-04", "20:00", "20:30"),
            (3, "Estados Unidos", "Corrida 1", "2025-05-05", "17:00", "17:30"),
            
            // Monaco GP (round 4)
            (4, "Mônaco", "Treino Livre", "2025-05-25", "08:30", "09:00"),
            (4, "Mônaco", "Classificação", "2025-05-25", "12:00", "12:30"),
            (4, "Mônaco", "Corrida 1", "2025-05-26", "10:00", "10:30"),
            
            // Spanish GP (round 5)
            (5, "Espanha", "Treino Livre", "2025-06-22", "09:30", "10:00"),
            (5, "Espanha", "Classificação", "2025-06-22", "13:00", "13:30"),
            (5, "Espanha", "Corrida 1", "2025-06-23", "11:00", "11:30"),
            
            // Hungarian GP (round 6)
            (6, "Hungria", "Treino Livre", "2025-07-20", "08:30", "09:00"),
            (6, "Hungria", "Classificação", "2025-07-20", "12:00", "12:30"),
            (6, "Hungria", "Corrida 1", "2025-07-21", "10:00", "10:30"),
            
            // Belgian GP (round 7)
            (7, "Bélgica", "Treino Livre", "2025-07-27", "09:30", "10:00"),
            (7, "Bélgica", "Classificação", "2025-07-27", "13:00", "13:30"),
            (7, "Bélgica", "Corrida 1", "2025-07-28", "11:00", "11:30"),
            
            // Netherlands GP (round 8)
            (8, "Holanda", "Treino Livre", "2025-08-24", "09:30", "10:00"),
            (8, "Holanda", "Classificação", "2025-08-24", "13:00", "13:30"),
            (8, "Holanda", "Corrida 1", "2025-08-25", "11:00", "11:30"),
            
            // Qatar GP (round 9)
            (9, "Catar", "Treino Livre", "2025-11-30", "11:30", "12:00"),
            (9, "Catar", "Classificação", "2025-11-30", "15:00", "15:30"),
            (9, "Catar", "Corrida 1", "2025-12-01", "13:00", "13:30")
        ]
        
        
        let f2Events = [
            // Bahrain GP (round 1)
            (1, "Bahrain", "Treino Livre", "2025-03-01", "08:00", "08:45"),
            (1, "Bahrain", "Classificação", "2025-03-01", "12:00", "12:30"),
            (1, "Bahrain", "Corrida Sprint", "2025-03-02", "10:00", "10:45"),
            (1, "Bahrain", "Corrida Principal", "2025-03-03", "07:00", "08:10"),
            
            // Arábia Saudita GP (round 2)
            (2, "Arábia Saudita", "Treino Livre", "2025-03-08", "08:00", "08:45"),
            (2, "Arábia Saudita", "Classificação", "2025-03-08", "12:00", "12:30"),
            (2, "Arábia Saudita", "Corrida Sprint", "2025-03-09", "10:00", "10:45"),
            (2, "Arábia Saudita", "Corrida Principal", "2025-03-10", "07:00", "08:10"),
            
            // Australian GP (round 3)
            (3, "Austrália", "Treino Livre", "2025-03-22", "22:00", "22:45"),
            (3, "Austrália", "Classificação", "2025-03-22", "06:30", "07:00"),
            (3, "Austrália", "Corrida Sprint", "2025-03-23", "23:15", "24:00"),
            (3, "Austrália", "Corrida Principal", "2025-03-24", "20:30", "21:40"),
            
            // Imola GP (round 4)
            (4, "Itália", "Treino Livre", "2025-05-16", "06:05", "06:50"),
            (4, "Itália", "Classificação", "2025-05-16", "11:00", "11:30"),
            (4, "Itália", "Corrida Sprint", "2025-05-17", "09:15", "10:00"),
            (4, "Itália", "Corrida Principal", "2025-05-18", "05:00", "06:10"),
            
            // Monaco GP (round 5)
            (5, "Mônaco", "Treino Livre", "2025-05-23", "01:00", "01:45"),
            (5, "Mônaco", "Classificação", "2025-05-23", "10:00", "10:30"),
            (5, "Mônaco", "Corrida Sprint", "2025-05-24", "10:10", "10:55"),
            (5, "Mônaco", "Corrida Principal", "2025-05-25", "04:40", "05:50"),
            
            // Spanish GP (round 6)
            (6, "Espanha", "Treino Livre", "2025-05-30", "06:05", "06:50"),
            (6, "Espanha", "Classificação", "2025-05-30", "11:00", "11:30"),
            (6, "Espanha", "Corrida Sprint", "2025-05-31", "09:15", "10:00"),
            (6, "Espanha", "Corrida Principal", "2025-06-01", "05:00", "06:10"),
            
            // Austrian GP (round 7)
            (7, "Austria", "Treino Livre", "2025-06-27", "08:05", "08:50"),
            (7, "Austria", "Classificação", "2025-06-27", "12:55", "13:25"),
            (7, "Austria", "Corrida Sprint", "2025-06-28", "11:15", "12:00"),
            (7, "Austria", "Corrida Principal", "2025-06-29", "07:00", "08:00"),
            
            // British GP (round 8)
            (8, "UK", "Treino Livre", "2025-07-04", "07:30", "08:15"),
            (8, "UK", "Classificação", "2025-07-04", "12:00", "12:30"),
            (8, "UK", "Corrida Sprint", "2025-07-05", "10:30", "11:15"),
            (8, "UK", "Corrida Principal", "2025-07-06", "07:00", "08:10"),
            
            // Hungarian GP (round 9)
            (9, "Hungria", "Treino Livre", "2025-07-18", "06:00", "06:45"),
            (9, "Hungria", "Classificação", "2025-07-18", "11:00", "11:30"),
            (9, "Hungria", "Corrida Sprint", "2025-07-19", "09:15", "10:00"),
            (9, "Hungria", "Corrida Principal", "2025-07-20", "05:00", "06:10"),
            
            // Belgian GP (round 10)
            (10, "Bélgica", "Treino Livre", "2025-07-25", "07:00", "07:45"),
            (10, "Bélgica", "Classificação", "2025-07-25", "12:00", "12:30"),
            (10, "Bélgica", "Corrida Sprint", "2025-07-26", "10:00", "10:45"),
            (10, "Bélgica", "Corrida Principal", "2025-07-27", "07:00", "08:10"),
            
            // Netherlands GP (round 11)
            (11, "Holanda", "Treino Livre", "2025-08-22", "07:00", "07:45"),
            (11, "Holanda", "Classificação", "2025-08-22", "12:00", "12:30"),
            (11, "Holanda", "Corrida Sprint", "2025-08-23", "10:00", "10:45"),
            (11, "Holanda", "Corrida Principal", "2025-08-24", "07:00", "08:10"),
            
            // Italian GP (round 12)
            (12, "Itália", "Treino Livre", "2025-08-29", "06:05", "06:50"),
            (12, "Itália", "Classificação", "2025-08-29", "11:00", "11:30"),
            (12, "Itália", "Corrida Sprint", "2025-08-30", "09:15", "10:00"),
            (12, "Itália", "Corrida Principal", "2025-08-31", "05:00", "06:10"),
            
            // Azerbaijan GP (round 13)
            (13, "Azerbaijão", "Treino Livre", "2025-09-13", "04:00", "04:45"),
            (13, "Azerbaijão", "Classificação", "2025-09-13", "09:00", "09:30"),
            (13, "Azerbaijão", "Corrida Sprint", "2025-09-14", "07:15", "08:00"),
            (13, "Azerbaijão", "Corrida Principal", "2025-09-15", "04:00", "05:10"),
            
            // Abu Dhabi GP (round 14)
            (14, "UAE", "Treino Livre", "2025-12-06", "05:00", "05:45"),
            (14, "UAE", "Classificação", "2025-12-06", "10:00", "10:30"),
            (14, "UAE", "Corrida Sprint", "2025-12-07", "08:15", "09:00"),
            (14, "UAE", "Corrida Principal", "2025-12-08", "05:00", "06:10"),
            
        ]
        
        
        let f3Events = [
            // Bahrain GP (round 1)
            (1, "Bahrain", "Treino Livre", "2025-03-01", "09:00", "09:30"),
            (1, "Bahrain", "Classificação", "2025-03-01", "13:00", "13:30"),
            (1, "Bahrain", "Corrida 1", "2025-03-02", "11:00", "11:45"),
            (1, "Bahrain", "Corrida 2", "2025-03-03", "09:00", "09:45"),
            
            // Australian GP (round 2)
            (2, "Austrália", "Treino Livre", "2025-03-22", "23:00", "23:30"),
            (2, "Austrália", "Classificação", "2025-03-22", "07:30", "08:00"),
            (2, "Austrália", "Corrida 1", "2025-03-23", "00:15", "01:00"),
            (2, "Austrália", "Corrida 2", "2025-03-24", "21:30", "22:15"),
            
            // Imola GP (round 3)
            (3, "Itália", "Treino Livre", "2025-05-17", "07:00", "07:30"),
            (3, "Itália", "Classificação", "2025-05-17", "12:00", "12:30"),
            (3, "Itália", "Corrida 1", "2025-05-18", "10:15", "11:00"),
            (3, "Itália", "Corrida 2", "2025-05-19", "06:00", "06:45"),
            
            // Monaco GP (round 4)
            (4, "Mônaco", "Treino Livre", "2025-05-24", "02:00", "02:30"),
            (4, "Mônaco", "Classificação", "2025-05-24", "11:00", "11:30"),
            (4, "Mônaco", "Corrida 1", "2025-05-25", "11:10", "11:55"),
            (4, "Mônaco", "Corrida 2", "2025-05-26", "05:40", "06:25"),
            
            // Spanish GP (round 5)
            (5, "Espanha", "Treino Livre", "2025-06-21", "07:00", "07:30"),
            (5, "Espanha", "Classificação", "2025-06-21", "12:00", "12:30"),
            (5, "Espanha", "Corrida 1", "2025-06-22", "10:15", "11:00"),
            (5, "Espanha", "Corrida 2", "2025-06-23", "06:00", "06:45"),
            
            // Austrian GP (round 6)
            (6, "Áustria", "Treino Livre", "2025-06-28", "09:00", "09:30"),
            (6, "Áustria", "Classificação", "2025-06-28", "13:55", "14:25"),
            (6, "Áustria", "Corrida 1", "2025-06-29", "12:15", "13:00"),
            (6, "Áustria", "Corrida 2", "2025-06-30", "08:00", "08:45"),
            
            // British GP (round 7)
            (7, "Reino Unido", "Treino Livre", "2025-07-05", "08:30", "09:00"),
            (7, "Reino Unido", "Classificação", "2025-07-05", "13:00", "13:30"),
            (7, "Reino Unido", "Corrida 1", "2025-07-06", "11:30", "12:15"),
            (7, "Reino Unido", "Corrida 2", "2025-07-07", "08:00", "08:45"),
            
            // Hungarian GP (round 8)
            (8, "Hungria", "Treino Livre", "2025-07-19", "07:00", "07:30"),
            (8, "Hungria", "Classificação", "2025-07-19", "12:00", "12:30"),
            (8, "Hungria", "Corrida 1", "2025-07-20", "10:15", "11:00"),
            (8, "Hungria", "Corrida 2", "2025-07-21", "06:00", "06:45"),
            
            // Belgian GP (round 9)
            (9, "Bélgica", "Treino Livre", "2025-07-26", "08:00", "08:30"),
            (9, "Bélgica", "Classificação", "2025-07-26", "13:00", "13:30"),
            (9, "Bélgica", "Corrida 1", "2025-07-27", "11:00", "11:45"),
            (9, "Bélgica", "Corrida 2", "2025-07-28", "08:00", "08:45"),
            
            // Netherlands GP (round 10)
            (10, "Holanda", "Treino Livre", "2025-08-23", "08:00", "08:30"),
            (10, "Holanda", "Classificação", "2025-08-23", "13:00", "13:30"),
            (10, "Holanda", "Corrida 1", "2025-08-24", "11:00", "11:45"),
            (10, "Holanda", "Corrida 2", "2025-08-25", "08:00", "08:45")
        ]
        
        for event in f1AcademyEvents {
            let date = dateFormatter.date(from: event.3)
            
            await database.addEvent(
                roundNumber: Int16(event.0),
                country: event.1,
                name: event.2,
                date: date,
                startTime: event.4,
                endTime: event.5,
                idFormula: f1AcademyId
            )
        }
        
        for event in f3Events {
            let date = dateFormatter.date(from: event.3)
            
            await database.addEvent(
                roundNumber: Int16(event.0),
                country: event.1,
                name: event.2,
                date: date,
                startTime: event.4,
                endTime: event.5,
                idFormula: f3Id
            )
        }
        
        
        for event in f2Events {
            let date = dateFormatter.date(from: event.3)
            
            await database.addEvent(
                roundNumber: Int16(event.0),
                country: event.1,
                name: event.2,
                date: date,
                startTime: event.4,
                endTime: event.5,
                idFormula: f2Id
            )
        }
    }
    
    private func seedComponents() async {
        print("Seeding components...")
        
        let existingComponents = await database.getAllComponents()
        if !existingComponents.isEmpty {
            print("Components already exist, skipping...")
            return
        }
        
        let components = [
            ("Motor", "O motor é a base do carro de Fórmula 2, e por se tratar de uma categoria de especificação, deve ser o mesmo em todos os carros do grid.", "Os motores atuais são motores V6 turboalimentados de 3,4 L são fornecidos pela Mecachrome. Funcionam com combustível sustentável avançado da Aramco e incorporam um sistema de acelerador fly-by-wire, produzindo 620 cavalos de potência a 8.750 rpm.", "engine_image"),
            ("Câmbio", "O câmbio é responsável pelas trocas de marcha durante a pilotagem e influencia diretamente no desempenho do carro em aceleração e retomada.", "Todos os carros utilizam um câmbio de seis marchas com trocas sequenciais sem interrupção (seamless shift), operado por paddle shifters localizados atrás do volante.", "gearbox_image"),
            ("Chassi", "O chassi é a estrutura central do carro, projetado para ser leve, resistente e garantir a segurança do piloto.", "Os carros da Fórmula 2 utilizam um chassi monocoque em fibra de carbono, desenvolvido pela Dallara, que atende aos mais altos padrões de segurança da FIA.", "chassis_image"),
            ("Suspensão", "A suspensão é responsável por manter o contato dos pneus com o solo, absorver impactos e garantir estabilidade nas curvas.", "A Fórmula 2 utiliza um sistema de suspensão do tipo pushrod, tanto na dianteira quanto na traseira, ajustável para diferentes condições de pista.", "suspension_image"),
            ("Freios", "O sistema de freios é essencial para o controle do carro, especialmente em frenagens fortes durante as corridas.", "Os carros são equipados com discos de freio de carbono-carbono (carbon ceramic) e pinças de alumínio da Brembo, oferecendo alta resistência térmica e desempenho constante.", "brakes_image"),
            ("Aerodinâmica", "A aerodinâmica ajuda a manter o carro estável em alta velocidade, gerando pressão contra o solo (downforce).", "O pacote aerodinâmico da Fórmula 2 inclui asas dianteiras e traseiras ajustáveis, projetadas para maximizar o equilíbrio entre velocidade em reta e aderência em curvas.", "aero_image"),
            ("Pneus", "Os pneus são o único ponto de contato entre o carro e o asfalto, sendo fundamentais para desempenho e estratégia de corrida.", "A Fórmula 2 utiliza pneus slick e de chuva fornecidos exclusivamente pela Pirelli, com compostos que variam de acordo com a etapa da temporada.", "tire_image")
        ]
        for comp in components {
            await database.addComponent(
                name: comp.0,
                details: comp.1,
                property: comp.2,
                image: comp.3,
            )
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
