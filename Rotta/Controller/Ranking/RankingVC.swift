//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class RankingVC: UIViewController {
    var drivers: [Driver] = []
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
        if let f2Id = Database.shared.getFormulaId(for: "Formula 2") {
            drivers = Database.shared.getDriversByFormula(idFormula: f2Id)
        } else {
            print("nenhum driver.")
            drivers = []
        }
        drivers.sort { $0.points > $1.points }
        rankingTableView.tableView.reloadData()
    }
}

