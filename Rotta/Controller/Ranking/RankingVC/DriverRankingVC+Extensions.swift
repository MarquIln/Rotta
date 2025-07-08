//
//  RankingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

extension DriverRankingVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(rankingTableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            rankingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            rankingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            rankingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            rankingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension DriverRankingVC: DriverRankingTableViewDelegate {
    func rankingTableView(_ view: DriverRankingTableView, didSelect driver: DriverModel) {
        let detailVC = DriverDetailsVC(driver: driver)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension DriverRankingVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.view.addGradientCardInfos()
        }
    }
}

extension DriverRankingVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
