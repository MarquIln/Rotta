//
//  RakingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit
import CloudKit

extension RankingVC: TopThreeTableViewDelegate {
    func numberOfDrivers() -> Int {
        return drivers.count
    }

    func driver(at index: Int) -> CKRecord {
        return CKRecord(recordType: "Driver")
    }

    func didScrollWithPosition(_ position: CGFloat, difference: CGFloat) {
        let currentPosition = position
        let difference = abs(currentPosition - lastScrollPosition)

        if difference >= scrollDistance {
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
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            rankingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            rankingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            rankingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            rankingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}
