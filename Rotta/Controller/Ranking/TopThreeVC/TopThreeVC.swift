//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class TopThreeVC: UIViewController {
    var drivers: [DriverModel] = []
    var scuderias: [ScuderiaModel] = []

    let database = Database.shared

    lazy var driverPodium: DriverPodium = {
        let view = DriverPodium()
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(seeAllDrivers)
            )
        )

        return view
    }()

    @objc func seeAllDrivers() {
        let vc = DriverRankingVC()
        vc.drivers = drivers
        vc.updateData(for: getCurrentFormula())
        navigationController?.pushViewController(vc, animated: false)
    }

    lazy var scuderiaPodium: ScuderiaPodium = {
        let view = ScuderiaPodium()
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(seeAllScuderias)
            )
        )

        return view
    }()

    @objc func seeAllScuderias() {
        let vc = ScuderiaRankingVC()
        vc.scuderias = scuderias
        vc.updateData(for: getCurrentFormula())
        navigationController?.pushViewController(vc, animated: false)
    }

    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [driverPodium, scuderiaPodium])
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadDrivers()
        loadScuderias()
    }

    private func loadDrivers() {
        Task {
            drivers = await database.getAllDrivers()

            drivers.sort { $0.points > $1.points }
            await MainActor.run {
                if drivers.count > 0 {
                    self.driverPodium.firstPlaceView.configure(
                        with: drivers[0],
                        rank: 1
                    )
                }
                if drivers.count > 1 {
                    self.driverPodium.secondPlaceView.configure(
                        with: drivers[1],
                        rank: 2
                    )
                }
                if drivers.count > 2 {
                    self.driverPodium.thirdPlaceView.configure(
                        with: drivers[2],
                        rank: 3
                    )
                }
            }
            await MainActor.run {
                self.driverPodium.update(with: drivers)
            }
        }
    }

    private func loadScuderias() {
        Task {
            scuderias = await database.getAllScuderias()

            scuderias.sort { $0.points > $1.points }
            await MainActor.run {
                if scuderias.count > 0 {
                    self.scuderiaPodium.firstPlaceView.configure(
                        with: scuderias[0],
                        rank: 1
                    )
                }
                if scuderias.count > 1 {
                    self.scuderiaPodium.secondPlaceView.configure(
                        with: scuderias[1],
                        rank: 2
                    )
                }
                if scuderias.count > 2 {
                    self.scuderiaPodium.thirdPlaceView.configure(
                        with: scuderias[2],
                        rank: 3
                    )
                }
            }
            await MainActor.run {
                self.scuderiaPodium.update(with: scuderias)
            }
        }
    }

    private func getCurrentFormula() -> FormulaType {
        if let tabController = self.tabBarController as? MainTabController {
            return tabController.currentFormula
        }
        return .formula2
    }
}

extension TopThreeVC: FormulaFilterable {
    func updateData(for formula: FormulaType) {
        Task {
            drivers = await database.getDrivers(for: formula)
            scuderias = await database.getScuderias(for: formula)

            await MainActor.run {
                updatePodiums()
            }
        }
    }

    private func updatePodiums() {
        // Atualizar pódio dos pilotos
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

        // Atualizar pódio das scuderias
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
