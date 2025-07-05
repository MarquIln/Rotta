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
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension TopThreeVC: FormulaFilterable {
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        driverPodium.showLoadingSkeleton()
        scuderiaPodium.showLoadingSkeleton()
        Task {
            drivers = await database.getDrivers(for: formula)
            scuderias = await database.getScuderias(for: formula)

            await MainActor.run {
                self.driverPodium.hideLoadingSkeleton()
                self.scuderiaPodium.hideLoadingSkeleton()
                updatePodiums()
            }
        }
    }

    private func updatePodiums() {
        drivers.sort { $0.points > $1.points }
        driverPodium.update(with: drivers)

        if drivers.count > 0 {
            driverPodium.firstPlaceView.configure(with: drivers[0], rank: 1)
        }
        if drivers.count > 1 {
            driverPodium.secondPlaceView.configure(with: drivers[1], rank: 2)
        }
        if drivers.count > 2 {
            driverPodium.thirdPlaceView.configure(with: drivers[2], rank: 3)
        }

        scuderias.sort { $0.points > $1.points }
        scuderiaPodium.update(with: scuderias)

        if scuderias.count > 0 {
            scuderiaPodium.firstPlaceView.configure(with: scuderias[0], rank: 1)
        }
        if scuderias.count > 1 {
            scuderiaPodium.secondPlaceView.configure(with: scuderias[1], rank: 2)
        }
        if scuderias.count > 2 {
            scuderiaPodium.thirdPlaceView.configure(with: scuderias[2], rank: 3)
        }
    }
}
