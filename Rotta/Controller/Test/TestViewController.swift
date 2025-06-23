import UIKit

class TestController: UIViewController {
    
    lazy var mainInfos: MainInfosDriverComponent = {
        let driver = MainInfosDriverComponent(country: "itália", driverNumber: 1, scuderia: "Invicta")
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var heightAndBirth: HeightAndBornComponent = {
        let driver = HeightAndBornComponent(height: "1,80", birthDate: "03.12.2004")
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var champion: ChampionComponent = {
        let driver = ChampionComponent(champion: "Campeonato de fórmula 3 da FIA de 2024")
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var descriptionComponent: DescriptionComponent = {
        let description = DescriptionComponent(description: "Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.")
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        descriptionComponent.setContentHuggingPriority(.required, for: .vertical)
        
        setup()

    }
}
//
extension TestController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(mainInfos)
        view.addSubview(heightAndBirth)
        view.addSubview(champion)
        view.addSubview(descriptionComponent)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainInfos.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            mainInfos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainInfos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainInfos.heightAnchor.constraint(equalToConstant: 95),
            
            heightAndBirth.topAnchor.constraint(equalTo: mainInfos.bottomAnchor, constant: 20),
            heightAndBirth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            heightAndBirth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            heightAndBirth.heightAnchor.constraint(equalToConstant: 46),
            
            champion.topAnchor.constraint(equalTo: heightAndBirth.bottomAnchor, constant: 20),
            champion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            champion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            champion.heightAnchor.constraint(equalToConstant: 46),
            
            descriptionComponent.topAnchor.constraint(equalTo: champion.bottomAnchor, constant: 20),
            descriptionComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            descriptionComponent.heightAnchor.constraint(equalToConstant: 222),
            descriptionComponent.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
