//
//  GlossaryWordDescription.swift
//  Rotta
//
//  Created by sofia leitao on 12/06/25.
//

import UIKit

class GlossaryDetails: UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DRS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var descripText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
Significa Sistema de Redução de Arrasto (Drag Reduction System em inglês) e é um sistema que reduz o arrasto aerodinâmico dos carros, permitindo-lhes alcançar velocidades máximas mais elevadas e, consequentemente, facilitando as ultrapassagens.
"""
        label.textColor = .white
        label.font = Fonts.BodyRegular
        label.textAlignment = .center
        
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descripContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()

    lazy var descrip2Title: UILabel = {
        var label = UILabel()
        label.text = "Zona de DRS"
        label.textColor = .white
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descrip2Text: UILabel = {
        var label = UILabel()
        label.text = """
O DRS pode ser usado pelos pilotos em zonas designadas durante os treinos livres, classificação e corridas. A pista tem zonas específicas onde o DRS pode ser ativado, com o carro perseguidor precisando estar a menos de um segundo do carro da frente para que a aba traseira se abra. O DRS é desativado ao final das zonas designadas e quando o piloto utiliza os freios
"""
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.BodyRegular
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackTexts: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descrip2Title, descrip2Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        return stack
    }()
    
    
    lazy var descrip2Container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()
    

    lazy var exploreContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var exploreCell: GlossaryExploreCell = {
            let cell = GlossaryExploreCell()
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, descripContainer, descrip2Container, exploreContainer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

}

extension GlossaryDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
        descripContainer.addSubview(descripText)
        descrip2Container.addSubview(stackTexts)
        exploreContainer.addSubview(exploreCell)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descripText.topAnchor.constraint(equalTo: descripContainer.topAnchor, constant: 12),
            descripText.bottomAnchor.constraint(equalTo: descripContainer.bottomAnchor, constant: -12),
            descripText.leadingAnchor.constraint(equalTo: descripContainer.leadingAnchor, constant: 16),
            descripText.trailingAnchor.constraint(equalTo: descripContainer.trailingAnchor, constant: -16),
            
            descrip2Title.topAnchor.constraint(equalTo: descrip2Container.topAnchor, constant: 12),
        
            descrip2Text.topAnchor.constraint(equalTo: descrip2Title.bottomAnchor, constant: 8),
            descrip2Text.bottomAnchor.constraint(equalTo: descrip2Container.bottomAnchor, constant: -12),
            descrip2Text.leadingAnchor.constraint(equalTo: descrip2Container.leadingAnchor, constant: 16),
            descrip2Text.trailingAnchor.constraint(equalTo: descrip2Container.trailingAnchor, constant: -16),
            
            exploreCell.topAnchor.constraint(equalTo: exploreContainer.topAnchor),
            exploreCell.bottomAnchor.constraint(equalTo: exploreContainer.bottomAnchor),
            exploreCell.leadingAnchor.constraint(equalTo: exploreContainer.leadingAnchor),
            exploreCell.trailingAnchor.constraint(equalTo: exploreContainer.trailingAnchor),
                       
           exploreContainer.heightAnchor.constraint(equalToConstant: 156)
    
        ])
    }
}

extension GlossaryDetails {
    
    func configure(with model: GlossaryModel) {
        label.text = model.title
        descripText.text = model.details
        descrip2Title.text = model.subtitle
        descrip2Text.text = model.details
        
    }
}
    
