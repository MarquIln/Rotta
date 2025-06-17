//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class RankingVC: UIViewController {
    var drivers: [DriverModel] = []
    let database = Database.shared
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    var lastScrollPosition: CGFloat = 0
    let scrollDistance: CGFloat = 30.0

    lazy var rankingTableView: TopThreeTableView = {
        let tableView = TopThreeTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadDrivers()
        impactFeedback.prepare()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDrivers()
    }

    private func loadDrivers() {
        Task {
            drivers = await database.getAllDrivers()

            drivers.sort { $0.points > $1.points }
            await MainActor.run {
                self.rankingTableView.tableView.reloadData()
            }
        }
    }
}
