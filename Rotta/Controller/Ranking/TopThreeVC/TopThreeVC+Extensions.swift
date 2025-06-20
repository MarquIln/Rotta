//
//  RakingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

extension TopThreeVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(stackView)
        mainDriverStack.addSubview(gradientView)
        mainScuderiaStack.addSubview(gradientView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            gradientView.topAnchor.constraint(equalTo: mainDriverStack.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: mainDriverStack.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: mainDriverStack.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: mainDriverStack.trailingAnchor)
        ])
    }
}
