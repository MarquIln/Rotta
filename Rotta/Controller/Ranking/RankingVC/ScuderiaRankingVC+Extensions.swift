//
//  RankingVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

extension ScuderiaRankingVC: ViewCodeProtocol {
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

extension ScuderiaRankingVC: ScuderiaRankingTableViewDelegate {
    func rankingTableView(_ view: ScuderiaRankingTableView, didSelect scuderia: ScuderiaModel) {
        let detailsVC = ScuderiaDetailsVC()
        detailsVC.scuderia = scuderia
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ScuderiaRankingVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.view.addGradientCardInfos()
        }
    }
}

extension ScuderiaRankingVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
            UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
