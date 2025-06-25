//
//  MainInfosDriver.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 20/06/25.
//
import UIKit
class MainInfosDriverComponent: UIView {
    var country: String
    var driverNumber: String
    var scuderia: String
    
    
    //country
    lazy var countryTitle: UILabel = {
        let label = UILabel()
        label.text = "País"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = country.getCountryFlag()
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var countryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryTitle, countryLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    //car
    lazy var carTitle: UILabel = {
        let label = UILabel()
        label.text = "Carro"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var carLabel: UILabel = {
        let label = UILabel()
        label.text = driverNumber
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var carStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [carTitle, carLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.backgroundColor = .fillsTextboxSecondary
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    //scuderia
    lazy var scuderiaTitle: UILabel = {
        let label = UILabel()
        label.text = "Equipe"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var scuderiaLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: scuderia)
        imageView.backgroundColor = .clear
        imageView.isOpaque = false
        
        return imageView
    }()
    
    lazy var scuderiaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [scuderiaTitle, scuderiaLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        stack.alignment = .center
        return stack
    }()
    
    // Divider
    lazy var divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextbox
        return view
    }()
    
    lazy var divider2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextbox
        return view
    }()
    
    //general stack
    lazy var generalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryStack, divider1, carStack, divider2, scuderiaStack])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    init(country: String, driverNumber: Int16, scuderia: String) {
        self.country = country
        self.driverNumber = String(driverNumber)
        self.scuderia = scuderia
        
        super.init(frame: .zero)
        
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainInfosDriverComponent: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(generalStack)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            generalStack.topAnchor.constraint(equalTo: topAnchor),
            generalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            generalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            generalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            divider1.widthAnchor.constraint(equalToConstant: 1),
            divider1.heightAnchor.constraint(equalTo: self.heightAnchor),
            divider2.widthAnchor.constraint(equalToConstant: 1),
            divider2.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            countryStack.widthAnchor.constraint(equalTo: carStack.widthAnchor),
            carStack.widthAnchor.constraint(equalTo: scuderiaStack.widthAnchor),
            
            scuderiaLabel.widthAnchor.constraint(equalToConstant: 67),
            scuderiaLabel.heightAnchor.constraint(equalToConstant: 37.79),
            
            countryLabel.widthAnchor.constraint(equalToConstant: 34),
            countryLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
}
