//
//  GlossaryTableViewController.swift
//  Rotta
//
//  Created by sofia leitao on 16/06/25.
//


import UIKit

class GlossaryTableViewController: UIViewController {
    
    private lazy var headerView: GlossaryHeaderView = {
        let headerView = GlossaryHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0
    
    private lazy var glossaryTableView: GlossaryTableView = {
        let tableView = GlossaryTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()

    private let totalCells = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        impactFeedback.prepare()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Glossário"
        
        view.addSubview(headerView)
        view.addSubview(glossaryTableView)
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            glossaryTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 268),
            glossaryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glossaryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glossaryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        glossaryTableView.reloadData()
    }
}

extension GlossaryTableViewController: GlossaryTableViewDelegate {
  
    func numberOfItems() -> Int {
        return totalCells
    }
    
    func item(at index: Int) -> (title: String, imageName: String) {
        return ("DRS", "carro")
    }
}
