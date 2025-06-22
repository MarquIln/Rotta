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
        ])
    }
}
