//
//  DriverPageViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 20/06/25.
//

import UIKit

class DriverPageViewController: UIViewController {
    var driver: DriverModel
    private var country: String
    private var number: Int16
    private var scuderiaLogo: String
    private var height: String
    private var birthDate: String
    private var championship: String
    private var details: String
    
    lazy var imagebackground: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: driver.name))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: driver.photo!) ?? UIImage(systemName: "person.fill")
        return imageView
    }()
    
    lazy var backgroundColor: UIView = {
        let view = UIView()
        view.backgroundColor = .raceFormula250
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
//        label.text = "Leonardo Fornaroli"
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
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
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
        view.backgroundColor = .raceFormula2
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

extension DriverPageViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imagebackground)
        view.addSubview(backgroundColor)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gradientView)
        
        contentView.addSubview(NameLabel)
        contentView.addSubview(mainInfos)
        contentView.addSubview(heightAndBirth)
        contentView.addSubview(champion)
        contentView.addSubview(descriptionComponent)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imagebackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imagebackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imagebackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imagebackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            backgroundColor.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundColor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundColor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            NameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 265),
            NameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            NameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            NameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            NameLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 265),
            
            mainInfos.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 20),
            mainInfos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainInfos.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainInfos.heightAnchor.constraint(equalToConstant: 95),
            
            heightAndBirth.topAnchor.constraint(equalTo: mainInfos.bottomAnchor, constant: 20),
            heightAndBirth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heightAndBirth.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heightAndBirth.heightAnchor.constraint(equalToConstant: 46),
            
            champion.topAnchor.constraint(equalTo: heightAndBirth.bottomAnchor, constant: 20),
            champion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            champion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            champion.heightAnchor.constraint(equalToConstant: 46),
            
            descriptionComponent.topAnchor.constraint(equalTo: champion.bottomAnchor, constant: 20),
            descriptionComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionComponent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension DriverPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
