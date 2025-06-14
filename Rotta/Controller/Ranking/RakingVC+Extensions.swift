//
//  RakingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

extension RankingVC: RankingTableViewDelegate {
    func numberOfDrivers() -> Int {
        return drivers.count
    }

    func driver(at index: Int) -> Driver {
        return drivers[index]
    }

    func didScrollWithPosition(_ position: CGFloat, difference: CGFloat) {
        let currentPosition = position
        let difference = abs(currentPosition - lastScrollPosition)

        if difference >= scrollThreshold {
            impactFeedback.impactOccurred(intensity: 0.5)
            lastScrollPosition = currentPosition
            impactFeedback.prepare()
        }
    }

    func willBeginDragging(at position: CGFloat) {
        impactFeedback.prepare()
        lastScrollPosition = position
    }

    func didEndDecelerating(at position: CGFloat) {
        lastScrollPosition = position
    }
}

extension RankingVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(rankingTableView)
        view.addSubview(viewAllDriversButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            rankingTableView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 20
            ),
            rankingTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            rankingTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            rankingTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            viewAllDriversButton.topAnchor.constraint(
                equalTo: rankingTableView.bottomAnchor
            ),
            viewAllDriversButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
        ])
    }
}
