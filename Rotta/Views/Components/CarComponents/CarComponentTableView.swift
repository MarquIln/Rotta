//
//  CarComponentTableView.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentTableView: UIView {

    var carComponents: [ComponentModel] = []

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.backgroundView = nil
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.register(CarComponentCell.self, forCellReuseIdentifier: CarComponentCell.reuseIdentifier)

        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
