import UIKit

class TestController: UIViewController {
    
    lazy var driver: MainInfosDriverComponent = {
        let driver = MainInfosDriverComponent(country: "itália", driverNumber: 1, scuderia: "Invicta")
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
        view.addSubview(driver)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            driver.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 306),
            driver.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            driver.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            driver.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -319),
        ])
    }
}
