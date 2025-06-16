//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class RankingViewController: UIViewController {
    private var drivers: [Driver] = []
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0
    
    private lazy var rankingTableView: RankingTableView = {
        let tableView = RankingTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadDrivers()
        impactFeedback.prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDrivers()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(rankingTableView)
        
        NSLayoutConstraint.activate([
            rankingTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            rankingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rankingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rankingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadDrivers() {
        if let f2Id = Database.shared.getFormulaId(for: "Formula 2") {
            drivers = Database.shared.getDriversByFormula(idFormula: f2Id)
        } else {
            drivers = []
        }
        drivers.sort { $0.points > $1.points }
        rankingTableView.reloadData()
    }
}

extension RankingViewController: RankingTableViewDelegate {
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
