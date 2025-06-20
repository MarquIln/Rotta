//
//  RakingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

extension TopThreeVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(mainDriverStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainDriverStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60),
            mainDriverStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainDriverStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            driverHeaderView.centerXAnchor.constraint(equalTo: mainDriverStack.centerXAnchor),
        ])
    }
}
