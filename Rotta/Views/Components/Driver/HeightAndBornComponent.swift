//
//  HeightAndBornComponent.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 22/06/25.
//
import UIKit
class HeightAndBornComponent: UIView {
    var height: String = ""
    var birthDate: String = ""
    
    lazy var heightText: UILabel = {
        let label = UILabel()
        label.text = "Altura"
        label.textColor = .labelsPrimary
        label.font = Fonts.FootnoteRegular
        return label
    }()
    
    lazy var heightVariable: UILabel = {
        let label = UILabel()
        label.text = "\(height)m"
        label.textColor = .labelsPrimary
        label.font = Fonts.FootnoteRegular
        return label
    }()
    
    lazy var heightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heightText, heightVariable])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextbox
        return view
    }()
    
    lazy var coloredStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heightStack, divider])
        stack.axis = .horizontal
        stack.backgroundColor = .fillsTextboxSecondary
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 27.5, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 27.5
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var birthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Nascido em \(birthDate)"
        label.textColor = .labelsPrimary
        label.font = Fonts.FootnoteRegular
        return label
    }()
    
    lazy var componentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coloredStack, birthDayLabel])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 27.5
        stack.distribution = .fillProportionally
        return stack
    }()
    
    init(height: String, birthDate: String) {
        self.height = height
        self.birthDate = birthDate
        
        super.init(frame: .zero)
        
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        clipsToBounds = true
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
extension HeightAndBornComponent: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
//        addSubview(heightLabel)
//        addSubview(birthDateLabel)
//        addSubview(divider)
        addSubview(componentStack)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            heightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27.5),
//            heightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            
//            divider.leadingAnchor.constraint(equalTo: heightLabel.trailingAnchor, constant: 27.5),
//            divider.widthAnchor.constraint(equalToConstant: 1),
//            
//            birthDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            birthDateLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 27.5)
            
            componentStack.topAnchor.constraint(equalTo: topAnchor),
            componentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            componentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27.5),
            componentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            divider.widthAnchor.constraint(equalToConstant: 1),
        ])
    }
}
