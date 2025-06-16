import Foundation
import CoreData

extension Database {
    
    func seedDatabase() {
        if !getAllFormulas().isEmpty {
            print("Database already seeded")
            return
        }
        
        print("Starting database seed...")
        
        seedFormulas()
        seedScuderias()
        seedDrivers()
        seedTracks()
        seedGlossary()
        seedRules()
        
        print("Database seed completed!")
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
            ("Campos Racing", "campos_logo", 95.0),
            ("MP Motorsport", "mp_logo", 83.0),
            ("PREMA Racing", "prema_logo", 40.0),
            ("Rodin Motorsport", "rodin_logo", 97.0),
            ("ART Grand Prix", "art_logo", 85.0),
            ("Hitech TGR", "hitech_logo", 73.0)
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
            ("Maya Weug", "Espanha", 1, "Campos Racing", 95.0),
            ("Bianca Bustamante", "Filipinas", 2, "MP Motorsport", 83.0),
            ("Carrie Schreiner", "Alemanha", 4, "Rodin Motorsport", 75.0),
            ("Aurelia Nobels", "Bélgica", 5, "ART Grand Prix", 67.0),
            ("Chloe Chong", "Estados Unidos", 6, "Hitech TGR", 58.0),
            ("Emely de Heus", "Holanda", 7, "Campos Racing", 44.0),
            ("Tina Hauger", "Noruega", 8, "MP Motorsport", 35.0),
            ("Hamda Al Qubaisi", "Emirados Árabes Unidos", 77, "PREMA Racing", 28.0),
            ("Lia Block", "Estados Unidos", 13, "Rodin Motorsport", 22.0),
            ("Jessica Edgar", "Reino Unido", 17, "ART Grand Prix", 18.0),
            ("Caterina Ciacci", "Itália", 18, "Hitech TGR", 15.0),
            ("Lola Lovinfosse", "Bélgica", 3, "PREMA Racing", 12.0)
        ]
        
        for (name, country, number, teamName, points) in f1AcademyDrivers {
            if let scuderiaId = getScuderiaId(name: teamName, formulaId: f1AcademyId) {
                addNewDriver(name: name, country: country, number: Int16(number), points: points, scuderia: scuderiaId, idFormula: f1AcademyId)
            }
        }
        
        let f2Drivers = [
            ("Alex Dunne", "Irlanda", 1, "MP Motorsport", 87.0),
            ("Richard Verschoor", "Holanda", 2, "MP Motorsport", 84.0),
            ("Arvid Lindblad", "Reino Unido", 3, "DAMS Lucas Oil", 79.0),
            ("Jak Crawford", "Estados Unidos", 4, "DAMS Lucas Oil", 73.0),
            ("Luke Browning", "Reino Unido", 5, "Hitech TGR", 73.0),
            ("Leonardo Fornaroli", "Argentina", 6, "Invicta Racing", 66.0),
            ("Josep Maria Marti", "Espanha", 7, "Campos Racing", 49.0),
            ("Victor Martins", "França", 8, "ART Grand Prix", 41.0),
            ("Sebastian Montoya", "Colômbia", 9, "Campos Racing", 36.0),
            ("Dino Beganovic", "Suécia", 10, "Rodin Motorsport", 29.0),
            ("Paul Aron", "Estônia", 11, "PREMA Racing", 21.0),
            ("Gabriele Mini", "Itália", 12, "PREMA Racing", 21.0),
            ("Enzo Gomes", "Brasil", 13, "Hitech TGR", 12.0),
            ("Roman Stanek", "República Tcheca", 14, "Invicta Racing", 12.0),
            ("Joshua Durksen", "Paraguai", 15, "AIX Racing", 11.0),
            ("Rafael Villagomez", "México", 16, "Van Amersfoort Racing", 10.0),
            ("Miyata Shingo", "Japão", 17, "ART Grand Prix", 5.0),
            ("Amaury Cordeel", "Bélgica", 18, "TRIDENT", 2.0),
            ("Sami Meguetounif", "França", 19, "TRIDENT", 1.0),
            ("Taylor Barnard", "Reino Unido", 20, "Rodin Motorsport", 0.0),
            ("Kush Maini", "Índia", 21, "Invicta Racing", 0.0),
            ("Isack Hadjar", "França", 22, "Van Amersfoort Racing", 0.0)
        ]
        
        for (name, country, number, teamName, points) in f2Drivers {
            if let scuderiaId = getScuderiaId(name: teamName, formulaId: f2Id) {
                addNewDriver(name: name, country: country, number: Int16(number), points: points, scuderia: scuderiaId, idFormula: f2Id)
            }
        }
        
        let f3Drivers = [
            ("Rafael Camara", "Brasil", 1, "Campos Racing", 105.0),
            ("Nikola Tsolov", "Bulgária", 2, "ART Grand Prix", 79.0),
            ("Tim Tramnitz", "Alemanha", 3, "TRIDENT", 70.0),
            ("Charlie Wurz", "Áustria", 4, "Hitech TGR", 56.0),
            ("Tuukka Taponen", "Finlândia", 5, "MP Motorsport", 51.0),
            ("Kacper Sztuka", "Polônia", 6, "MP Motorsport", 45.0),
            ("Noel Ramzi", "Singapura", 7, "Rodin Motorsport", 45.0),
            ("Martinius Stenshorne", "Noruega", 8, "Hitech TGR", 43.0),
            ("Callum Voisin", "Reino Unido", 9, "Rodin Motorsport", 41.0),
            ("Gabriel Biller", "Dinamarca", 10, "Campos Racing", 38.0),
            ("Laurens van Hoepen", "Holanda", 11, "ART Grand Prix", 37.0),
            ("Mari Boya", "Espanha", 12, "TRIDENT", 36.0),
            ("Sami Meguetounif", "França", 13, "Van Amersfoort Racing", 36.0),
            ("Domenico Lovera", "Itália", 14, "DAMS Lucas Oil", 18.0),
            ("Nikita Bedrin", "Itália", 15, "AIX Racing", 17.0),
            ("James Wharton", "Austrália", 16, "PREMA Racing", 15.0),
            ("Tasanapol Inthraphuvasak", "Tailândia", 17, "Rodin Motorsport", 15.0),
            ("Alex Dunne", "Irlanda", 18, "MP Motorsport", 11.0),
            ("Max Esterson", "Estados Unidos", 19, "Hitech TGR", 11.0),
            ("Ugo Ugochukwu", "Estados Unidos", 20, "PREMA Racing", 10.0),
            ("Matías Zagazeta", "Peru", 21, "DAMS Lucas Oil", 6.0),
            ("Arvid Lindblad", "Reino Unido", 22, "PREMA Racing", 4.0),
            ("Leonardo Fornaroli", "Argentina", 23, "TRIDENT", 4.0),
            ("Luke Browning", "Reino Unido", 24, "Campos Racing", 3.0),
            ("Noel León", "México", 25, "PREMA Racing", 4.0),
            ("Brando Badoer", "Itália", 26, "PREMA Racing", 0.0),
            ("William Alatalo", "Finlândia", 27, "Van Amersfoort Racing", 3.0)
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
            ("DRS", "Sistema de Redução de Arrasto (Drag Reduction System em inglês) que reduz o arrasto aerodinâmico dos carros, permitindo-lhes alcançar velocidades máximas mais elevadas e facilitando as ultrapassagens."),
            ("Pole Position", "A primeira posição no grid de largada, conquistada pelo piloto que registra o melhor tempo na sessão de classificação."),
            ("Chicane", "Uma sequência de curvas em formato de 'S' que força os pilotos a reduzirem a velocidade."),
            ("Pit Stop", "Parada nos boxes para troca de pneus, abastecimento ou reparos durante a corrida."),
            ("Safety Car", "Carro de segurança que entra na pista para controlar o ritmo quando há acidentes ou condições perigosas."),
            ("Undercut", "Estratégia onde um piloto para nos boxes antes do rival para ganhar posições com pneus frescos."),
            ("Overcut", "Estratégia oposta ao undercut, onde o piloto fica mais tempo na pista antes de parar nos boxes."),
            ("Slipstream", "Efeito aerodinâmico onde um carro segue outro muito próximo para reduzir a resistência do ar."),
            ("Apex", "O ponto ideal de uma curva, geralmente na parte interna, onde o carro deve passar para ter a melhor trajetória."),
            ("Dirty Air", "Ar turbulento criado pelo carro da frente que dificulta as ultrapassagens."),
            ("KERS", "Sistema de Recuperação de Energia Cinética que armazena energia das frenagens para uso posterior."),
            ("Parc Fermé", "Área restrita onde os carros ficam após a classificação, com regulamentações específicas sobre modificações.")
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
            ("Bandeiras", "Bandeira amarela: perigo, reduza velocidade. Bandeira vermelha: pare imediatamente. Bandeira azul: deixe o piloto mais rápido passar."),
            ("Limites da Pista", "Os pilotos devem manter pelo menos duas rodas dentro dos limites da pista em curvas. Violações resultam em penalidades."),
            ("Largada", "Largada será dada quando todas as luzes se apagarem. Largadas antecipadas resultam em penalidades."),
            ("Ultrapassagens", "Ultrapassagens devem ser feitas de forma segura e esportiva, sem forçar outro piloto para fora da pista.")
        ]
        
        let f1AcademyRules = [
            ("DRS", "O DRS pode ser usado em zonas designadas quando o piloto está a menos de 1 segundo do carro da frente."),
            ("Pontuação", "Sistema de pontuação: 25-18-15-12-10-8-6-4-2-1 para os 10 primeiros colocados."),
            ("Duração da Corrida", "Corridas têm duração de aproximadamente 30-40 minutos ou um número fixo de voltas.")
        ]
        
        let f2Rules = [
            ("Corridas", "Fim de semana com duas corridas: Sprint Race no sábado e Feature Race no domingo."),
            ("Pontuação", "Feature Race: 25-18-15-12-10-8-6-4-2-1. Sprint Race: 15-12-10-8-6-4-2-1 pontos."),
            ("Pneus", "Três compostos de pneus disponíveis por fim de semana: duro, médio e macio."),
            ("DRS", "Duas zonas de DRS por pista, ativação permitida após primeira volta.")
        ]
        
        let f3Rules = [
            ("Formato", "Três corridas por fim de semana: duas Sprint Races e uma Feature Race."),
            ("Pontuação Feature Race", "25-18-15-12-10-8-6-4-2-1 para os 10 primeiros colocados."),
            ("Pontuação Sprint Race", "10-8-6-5-4-3-2-1 para os 8 primeiros colocados."),
            ("Grid de Largada", "Grid da Corrida 1 baseado na classificação. Corrida 2 com grid invertido.")
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
}
