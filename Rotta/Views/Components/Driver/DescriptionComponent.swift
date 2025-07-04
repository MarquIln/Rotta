//
//  DescriptionComponent.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 23/06/25.
//
import UIKit
class DescriptionComponent: UIView {
    var driverDescription: String = ""
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = driverDescription
        label.textColor = .labelsPrimary
        label.font = Fonts.BodyRegular
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    init(description: String) {
        self.driverDescription = description
        
        super.init(frame: .zero)
        
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        clipsToBounds = true
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DescriptionComponent: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(descriptionLabel)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}
