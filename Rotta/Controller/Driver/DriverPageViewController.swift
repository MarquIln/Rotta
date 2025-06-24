//
//  DriverPageViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 20/06/25.
//
import UIKit
class DriverPageViewController: UIViewController {
    lazy var imagebackground: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "leonardo_fornaroli"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        button.setImage(image, for: .normal)
        
        button.tintColor = .rottaYellow
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.text = "Campeão:"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle2
        return label
    }()
    
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
    
    lazy var descriptionComponent2: DescriptionComponent = {
        let description = DescriptionComponent(description: "Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.Campeão da Fórmula 3 da FIA em 2024, com duas pole positions e sete pódios. Em 2023, terminou em 11º na F3 e foi o novato mais bem colocado no Europeu de Fórmula Regional, ficando em 8º com 83 pontos. Em 2025, passou a correr pela Champions Invicta Racing, após participar do teste pós-temporada e da etapa final em Yas Marina com a Rodin Motorsport.")
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    // 1. ScrollView que vai rolar o conteúdo verticalmente
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // 2. ContentView onde ficará todo o seu conteúdo
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sprintFormula2
//        view.backgroundColor = .white
        
        descriptionComponent.setContentHuggingPriority(.required, for: .vertical)
        
        addGradientGlossary()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        title = "Pilotos"
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        blurEffectView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setup()
        
    }
    
    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientDriverDetails()
        }
    }
}
//
extension DriverPageViewController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        //        view.addSubview(imagebackground)
        //        view.addSubview(backgroundColor)
        //        view.addSubview(gradientView)
        //
        //        view.addSubview(scrollView)
        //        // 2️⃣ adiciona o contentView dentro dele
        //        scrollView.addSubview(contentView)
        //
        ////        view.addSubview(headerView)
        ////        view.addSubview(mainInfos)
        ////        view.addSubview(heightAndBirth)
        ////        view.addSubview(champion)
        ////        view.addSubview(descriptionComponent)
        //
        //        contentView.addSubview(mainInfos)
        //        contentView.addSubview(heightAndBirth)
        //        contentView.addSubview(champion)
        //        contentView.addSubview(descriptionComponent)
        
        
        view.addSubview(imagebackground)
        view.addSubview(backgroundColor)
//        view.addSubview(gradientView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gradientView)
        
        contentView.addSubview(mainInfos)
        contentView.addSubview(heightAndBirth)
        contentView.addSubview(champion)
        contentView.addSubview(descriptionComponent)
        contentView.addSubview(descriptionComponent2)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            //            // 3. Pregar a scrollView na tela
            //            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            //            // 4. Pregar a contentView dentro da scrollView
            //            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            //            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            //            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            //            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            //            // 5. Largura fixa igual à largura visível da scrollView (sem rolar horizontal)
            //            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            //
            //            imagebackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            //            imagebackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            //            imagebackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            //            imagebackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            //
            //            backgroundColor.topAnchor.constraint(equalTo: view.topAnchor),
            //            backgroundColor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            backgroundColor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            backgroundColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            //            gradientView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            //            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            //            mainInfos.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            //            mainInfos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            mainInfos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //            mainInfos.heightAnchor.constraint(equalToConstant: 95),
            //
            //            heightAndBirth.topAnchor.constraint(equalTo: mainInfos.bottomAnchor, constant: 20),
            //            heightAndBirth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            heightAndBirth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //            heightAndBirth.heightAnchor.constraint(equalToConstant: 46),
            //
            //            champion.topAnchor.constraint(equalTo: heightAndBirth.bottomAnchor, constant: 20),
            //            champion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            champion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //            champion.heightAnchor.constraint(equalToConstant: 46),
            //
            //            descriptionComponent.topAnchor.constraint(equalTo: champion.bottomAnchor, constant: 20),
            //            descriptionComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            descriptionComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ////            descriptionComponent.heightAnchor.constraint(equalToConstant: 222),
            //            descriptionComponent.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            //
            //            descriptionComponent2.topAnchor.constraint(equalTo: descriptionComponent.bottomAnchor, constant: 20),
            //            descriptionComponent2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            descriptionComponent2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ////            descriptionComponent.heightAnchor.constraint(equalToConstant: 222),
            //            descriptionComponent2.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            
            
            
            
            
            // === BACKGROUND & GRADIENT ===
            //            backgroundColor.topAnchor.constraint(equalTo: view.topAnchor),
            //            backgroundColor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            backgroundColor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            backgroundColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            
            // === SCROLLVIEW & CONTENTVIEW ===
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            // === SUAS SUBVIEWS DENTRO DO contentView ===
            mainInfos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 265),
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
            champion.heightAnchor.constraint(equalToConstant: 46),
            
            descriptionComponent.topAnchor.constraint(equalTo: champion.bottomAnchor, constant: 20),
            descriptionComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionComponent2.topAnchor.constraint(equalTo: descriptionComponent.bottomAnchor, constant: 20),
            descriptionComponent2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionComponent2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionComponent2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
