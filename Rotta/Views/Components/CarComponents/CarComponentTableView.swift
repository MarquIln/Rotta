//
//  CarComponentTableView.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentTableView: UIView {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    var lastScrollPosition: CGFloat = 0
    let scrollThreshold: CGFloat = 20
    var lastFeedbackTime: CFTimeInterval = 0

    var carComponents: [ComponentModel] = []

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.backgroundView = nil
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 8
        table.layer.maskedCorners = [.layerMinXMinYCorner]
        
        table.register(CarComponentCell.self, forCellReuseIdentifier: CarComponentCell.reuseIdentifier)

        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        impactFeedback.prepare()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        impactFeedback.prepare()
        setup()
    }
        
    func configure(with components: [ComponentModel]) {
        self.carComponents = components
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
