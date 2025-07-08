//
//  DriverDetailsVC.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 20/06/25.
//

import UIKit

class DriverDetailsVC: UIViewController {
    var driver: DriverModel
    private var country: String
    private var number: Int16
    private var scuderiaLogo: String
    private var height: String
    private var birthDate: String
    private var championship: String
    private var details: String
    private var currentFormula: FormulaType = Database.shared.getSelectedFormula()
    
    lazy var imageBackground: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: driver.name))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: driver.photo!) ?? UIImage(systemName: "person.fill")
        return imageView
    }()
    
    lazy var backgroundColor: UIView = {
        let view = UIView()
        view.backgroundColor = FormulaColorManager.shared.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "chevron.left.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .rottaYellow
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.text = driver.name
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainInfos: MainInfosDriverComponent = {
        let driver = MainInfosDriverComponent(country: self.country, driverNumber: self.number, scuderia: self.scuderiaLogo)
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var heightAndBirth: HeightAndBornComponent = {
        let driver = HeightAndBornComponent(height: height, birthDate: birthDate)
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var champion: ChampionComponent = {
        let driver = ChampionComponent(champion: championship)
        driver.translatesAutoresizingMaskIntoConstraints = false
        return driver
    }()
    
    lazy var descriptionComponent: DescriptionComponent = {
        let description = DescriptionComponent(description: details)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    lazy var contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "pt_BR")
        fmt.timeZone = TimeZone(secondsFromGMT: 0)
        fmt.dateFormat = "dd/MM/yyyy"
        return fmt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        descriptionComponent.setContentHuggingPriority(.required, for: .vertical)
        
        addGradientGlossary()
        
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        
        setup()
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    init(driver: DriverModel) {
        self.driver = driver
        self.country = driver.country ?? "Unknown"
        if let country = driver.country {
            self.country = country
        }
        
        self.number = driver.number ?? 0
        if let number = driver.number {
            self.number = number
        }
        
        self.scuderiaLogo = driver.scuderiaLogo ?? "Unknown"
        if let scuderiaLogo = driver.scuderiaLogo {
            self.scuderiaLogo = scuderiaLogo
        }
        
        self.height = driver.height ?? "Unknown"
        if let height = driver.height {
            self.height = height
        }
        
        if let date = driver.birthDate {
          birthDate = dateFormatter.string(from: date)
        } else {
            birthDate = "--/--/----"
        }
        
        self.championship = driver.championship ?? "Unknown"
        if let championship = driver.championship {
            self.championship = championship
        }
        
        self.details = driver.details ?? "Unknown"
        if let details = driver.details {
            self.details = details
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não implementado")
    }
    
    @objc private func customBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCustomBackButton() {
        navigationItem.hidesBackButton = true
    
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        backButton.tintColor = .rottaYellow
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 16
        backButton.clipsToBounds = true
        backButton.addTarget(self, action: #selector(customBackTapped), for: .touchUpInside)
        
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func setupNavigationBar() {
        title = "Detalhes do Piloto"
        setupCustomBackButton()
    }
    
    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientDriverDetails()
        }
    }
}
