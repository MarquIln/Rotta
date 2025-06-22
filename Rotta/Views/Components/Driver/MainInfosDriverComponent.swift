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
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var countryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryTitle, countryLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
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
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var carStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [carTitle, carLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
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
    
    lazy var scuderiaLabel: UILabel = {
        let label = UILabel()
        label.text = scuderia
        label.textColor = .labelsPrimary
        label.font = Fonts.BodyRegular
        return label
    }()
    
    lazy var scuderiaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [scuderiaTitle, scuderiaLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    // Divider
    lazy var divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dividerPrimary
        return view
    }()
    
    lazy var divider2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dividerPrimary
        return view
    }()
    
    //general stack
    lazy var generalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryStack, divider1, carStack, divider2, scuderiaStack])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fill
//        stack.spacing = 34.17
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
            generalStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            generalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            generalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            generalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            divider1.widthAnchor.constraint(equalToConstant: 1),
            divider1.heightAnchor.constraint(equalTo: generalStack.heightAnchor),
            divider2.widthAnchor.constraint(equalToConstant: 1),
            divider2.heightAnchor.constraint(equalTo: generalStack.heightAnchor),

            countryStack.widthAnchor.constraint(equalTo: carStack.widthAnchor),
            carStack.widthAnchor.constraint(equalTo: scuderiaStack.widthAnchor),
        ])
    }
}
