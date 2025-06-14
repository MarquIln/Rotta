//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class RankingVC: UIViewController {
    var drivers: [Driver] = []
    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    var lastScrollPosition: CGFloat = 0
    let scrollThreshold: CGFloat = 30.0

    lazy var rankingTableView: RankingTableView = {
        let tableView = RankingTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self

        return tableView
    }()

    lazy var viewAllDriversButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellowPrimary
        button.setTitle("View all Standings", for: .normal)
        button.addTarget(
            self,
            action: #selector(viewAllDrivers),
            for: .touchUpInside
        )

        return button
    }()

    @objc private func viewAllDrivers() {
        print("vai ver todos os drivers sim.")
    }

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
        rankingTableView.reloadData()
    }
}

