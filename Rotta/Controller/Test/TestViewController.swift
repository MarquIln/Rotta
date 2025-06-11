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
            component.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            component.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            component.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            component.heightAnchor.constraint(equalToConstant: 44)

        ])
    }
    func addSubviews() {
        view.addSubview(component)

    }
}
