//
//  MainTabController+Extensions.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit

extension MainTabController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(titleSelectorButton)
        view.addSubview(segmented)
        view.addSubview(dropdownView)
        view.addSubview(profileButton)
    }

    func setupConstraints() {
        segmented.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleSelectorButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 44
            ),
            titleSelectorButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),

            dropdownView.topAnchor.constraint(
                equalTo: titleSelectorButton.bottomAnchor,
                constant: 4
            ),
            dropdownView.centerXAnchor.constraint(
                equalTo: titleSelectorButton.centerXAnchor
            ),
            dropdownView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),

            segmented.topAnchor.constraint(
                equalTo: titleSelectorButton.bottomAnchor,
                constant: 20
            ),
            segmented.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmented.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmented.heightAnchor.constraint(equalToConstant: 32),

            profileButton.centerYAnchor.constraint(
                equalTo: titleSelectorButton.centerYAnchor
            ),
            profileButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        segmented.didSelectSegment = { [weak self] index in
            self?.displayViewController(at: index)
        }
    }
}
