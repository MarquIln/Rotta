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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainInfos.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 404),
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
        ])
    }
}
