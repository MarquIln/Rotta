//
//  CarComponentDetails.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentDetails: UIView {
    
    var component: ComponentModel? = nil {
        didSet {
            if let component {
                configure(with: component)
            }
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = component?.name
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var descripText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = component?.details
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
    
    lazy var descrip2Text: UILabel = {
        var label = UILabel()
        label.text = component?.details
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.BodyRegular
        label.numberOfLines = 0
        return label
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
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, descripContainer, descrip2Container, exploreContainer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    init(frame: CGRect, component: ComponentModel) {
        super.init(frame: frame)
        self.component = component
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

}

extension CarComponentDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
        descripContainer.addSubview(descripText)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descripText.topAnchor.constraint(equalTo: descripContainer.topAnchor, constant: 12),
            descripText.bottomAnchor.constraint(equalTo: descripContainer.bottomAnchor, constant: -12),
            descripText.leadingAnchor.constraint(equalTo: descripContainer.leadingAnchor, constant: 16),
            descripText.trailingAnchor.constraint(equalTo: descripContainer.trailingAnchor, constant: -16),
        
            descrip2Text.topAnchor.constraint(equalTo: descripText.bottomAnchor, constant: 8),
            descrip2Text.bottomAnchor.constraint(equalTo: descrip2Container.bottomAnchor, constant: -12),
            descrip2Text.leadingAnchor.constraint(equalTo: descrip2Container.leadingAnchor, constant: 16),
            descrip2Text.trailingAnchor.constraint(equalTo: descrip2Container.trailingAnchor, constant: -16),
                       
           exploreContainer.heightAnchor.constraint(equalToConstant: 156)
    
        ])
    }
}

extension CarComponentDetails {
    func configure(with model: ComponentModel) {
        label.text = model.name
        descripText.text = model.details
//        descrip2Title.text = model.property
        
    }
}
    
