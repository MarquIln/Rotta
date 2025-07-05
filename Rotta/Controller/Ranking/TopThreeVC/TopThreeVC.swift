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
    var currentFormula: FormulaType = .formula2

    let database = Database.shared

    lazy var driverPodium: DriverPodium = {
        let view = DriverPodium()
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(seeAllDrivers)
            )
        )
        view.onSeeAllTapped = { [weak self] in
            self?.seeAllDrivers()
        }

        return view
    }()

    @objc func seeAllDrivers() {
        let vc = DriverRankingVC()
        vc.drivers = drivers
        vc.updateData(for: currentFormula)
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
        view.onSeeAllTapped = { [weak self] in
            self?.seeAllScuderias()
        }

        return view
    }()

    @objc func seeAllScuderias() {
        let vc = ScuderiaRankingVC()
        vc.scuderias = scuderias
        vc.updateData(for: currentFormula)
        navigationController?.pushViewController(vc, animated: false)
    }

    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [driverPodium, scuderiaPodium])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentFormula = UserPreferencesManager.shared.getSelectedFormula()
        
        setup()
        loadDrivers()
        loadScuderias()
    }

    private func loadDrivers() {
        driverPodium.showLoadingSkeleton()
        Task {
            drivers = await database.getDrivers(for: currentFormula)

            drivers.sort { $0.points > $1.points }
            await MainActor.run {
                self.driverPodium.hideLoadingSkeleton()
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
        scuderiaPodium.showLoadingSkeleton()
        Task {
            scuderias = await database.getScuderias(for: currentFormula)

            scuderias.sort { $0.points > $1.points }
            await MainActor.run {
                self.scuderiaPodium.hideLoadingSkeleton()
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
}
