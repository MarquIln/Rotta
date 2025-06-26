//
//  CarComponentDetails.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentDetails: UIView {
    var component: ComponentModel?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = component?.name
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var descripText: UILabel = {
        var label = UILabel()
        label.text = component?.details
        label.textColor = .white
        label.font = Fonts.BodyRegular
        label.textAlignment = .center
        
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descripContainer: UIView = {
        let view = UIView()
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
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()
    

    lazy var exploreContainer: UIView = {
        let view = UIView()
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
    
    func configure(with model: ComponentModel) {
        label.text = model.name
        descripText.text = model.details
//        descrip2Title.text = model.property
        
    }
}

extension CarComponentDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

