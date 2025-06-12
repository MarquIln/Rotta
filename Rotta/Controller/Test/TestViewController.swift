//
//  TestViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 11/06/25.
//

import UIKit
var strings = ["Calendário", "Ranking", "Infos"]

class TestController: UIViewController {
    lazy var component: SegmentedControll = {
        var component = SegmentedControll(items: strings)
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    lazy var cardInfo: CardInfosButton = {
        let image = CardInfosButton(title: "Categoria", subtitle: "Descricao")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .background
    }
}

extension TestController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func setupConstraints() {
        
       NSLayoutConstraint.activate([
//            component.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            component.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            component.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            component.heightAnchor.constraint(equalToConstant: 44)
        
        cardInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        cardInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        cardInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        cardInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        cardInfo.heightAnchor.constraint(equalTo: cardInfo.widthAnchor, multiplier: 0.5)

//        cardInfo.heightAnchor.constraint(equalToConstant: 44)
//        cardInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }
    func addSubviews() {
//        view.addSubview(component)
        view.addSubview(cardInfo)
    }
}
