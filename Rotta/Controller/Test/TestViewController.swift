//
//  TestViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 11/06/25.
//

import UIKit
var strings = ["Calendário", "Ranking", "Infos"]

class TestController: UIViewController {
//    lazy var segmentedControll: SegmentedControll = {
//        var component = SegmentedControll(items: strings)
//        component.translatesAutoresizingMaskIntoConstraints = false
//        return component
//    }()
    
//    lazy var cardInfo: CardInfosButton = {
//        let image = CardInfosButton(title: "Glossário", subtitle: "Entenda os principais termos utilizados na Fórmula 2")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//        
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
//        cardInfo.addTarget(
//            self,
//            action: #selector(cardInfoTapped(_:)),
//            for: .touchUpInside
//        )
        view.backgroundColor = .backgroundPrimary
        
    }
    
    @objc private func cardInfoTapped(_ sender: CardInfosButton) {
        print("CardInfosButton foi tocado!")
    }
}

extension TestController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func setupConstraints() {
        
       NSLayoutConstraint.activate([
//        segmentedControll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//        segmentedControll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//        segmentedControll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//        segmentedControll.heightAnchor.constraint(equalToConstant: 44),
        
//        cardInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//        cardInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//        cardInfo.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 16),
//        cardInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    func addSubviews() {
//        view.addSubview(segmentedControll)
//        view.addSubview(cardInfo)
    }
}
