//
//  ScuderiaHeader.swift
//  Rotta
//
//  Created by sofia leitao on 25/06/25.
//

import UIKit

class ScuderiaHeaderView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var logoImageViews: [UIImageView] = []
    
   
    private let teamLogos = [
        "aix_logo", "art_logo", "campos_logo", "dams_logo", "hitech_logo",
        "invicta_logo", "mp_logo", "prema_logo", "rodin_logo", "trident_logo"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        setupLogoViews()
    }
    
    private func setupLogoViews() {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 12
        verticalStack.alignment = .center
        verticalStack.distribution = .equalSpacing
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            verticalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            verticalStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
        
        // Dividir os logos em duas linhas (5 em cada)
        let firstRowLogos = Array(teamLogos.prefix(5))
        let secondRowLogos = Array(teamLogos.suffix(5))
        
        // Primeira linha
        let firstRowStack = createLogoRow(with: firstRowLogos)
        verticalStack.addArrangedSubview(firstRowStack)
        
        // Segunda linha
        let secondRowStack = createLogoRow(with: secondRowLogos)
        verticalStack.addArrangedSubview(secondRowStack)
    }
    
    private func createLogoRow(with logos: [String]) -> UIStackView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 12
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        for logoName in logos {
            let logoView = UIImageView()
            logoView.translatesAutoresizingMaskIntoConstraints = false
            logoView.contentMode = .scaleAspectFit
            logoView.image = UIImage(named: logoName)
            logoView.clipsToBounds = true
            
        
            logoView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            logoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            horizontalStack.addArrangedSubview(logoView)
            logoImageViews.append(logoView)
        }
        
        return horizontalStack
    }
}
