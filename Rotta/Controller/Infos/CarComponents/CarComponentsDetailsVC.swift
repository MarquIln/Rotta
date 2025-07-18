//
//  CarComponentsDetailsVC.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentsDetailsVC: UIViewController {
    var carComponent: ComponentModel?
    var allComponents: [ComponentModel] = []
    let database = Database.shared
    
    func configure(with component: ComponentModel) {
        self.carComponent = component
    }
    
    lazy var component: CarComponentDetails = {
        guard let componentUnwrapped = carComponent else {
            fatalError("Car component não pode ser nil ao criar o componente.")
        }
        
        var carComponent =  CarComponentDetails(frame: .zero, component: componentUnwrapped)
        carComponent.configure(with: componentUnwrapped)
        carComponent.translatesAutoresizingMaskIntoConstraints = false
        return carComponent
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()
    
    lazy var imageBackground: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalhes"
        setup()
        addGradientGlossary()
        setupCustomBackButton()
        configureImageBackground()
        loadAllComponents()
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
    
    private func configureImageBackground() {
        if let imageName = carComponent?.image {
            imageBackground.image = UIImage(named: imageName)
        }
    }
    
    private func loadAllComponents() {
        if !allComponents.isEmpty {
            component.exploreCell.configure(with: allComponents)
            return
        }
        
        Task {
            allComponents = await database.getAllComponents()
            
            await MainActor.run {
                component.exploreCell.configure(with: allComponents)
            }
        }
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
    
    
}

extension CarComponentsDetailsVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(gradientView)
        
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.addSubview(component)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: 362),
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 212),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            component.topAnchor.constraint(equalTo: contentView.topAnchor),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

    }
}

