//
//  RankingTableView.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit
import CloudKit
import SkeletonView

class RankingTableView: UIView {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    var lastScrollPosition: CGFloat = 0
    let scrollThreshold: CGFloat = 20
    var lastFeedbackTime: CFTimeInterval = 0

    var drivers: [DriverModel] = []

    lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.text = "Driver"
        label.textAlignment = .center
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textAlignment = .center
        label.text = "Points"
        label.textColor = .white


        return label
    }()

    lazy var scuderiaLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textAlignment = .center
        label.text = "Scuderia"
        label.textColor = .white

        return label
    }()

    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [driverLabel, pointsLabel, scuderiaLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .f2Corrida
        stack.alignment = .fill
        stack.layer.cornerRadius = 12

        stack.layer.maskedCorners = [
             .layerMinXMinYCorner,
             .layerMaxXMinYCorner
         ]
         stack.layer.masksToBounds = true

        return stack
    }()

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
        
        table.register(DriverRankingCell.self, forCellReuseIdentifier: DriverRankingCell.reuseIdentifier)
        table.isSkeletonable = true

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
        
    func configure(with drivers: [DriverModel]) {
        self.drivers = drivers
        tableView.reloadData()
        tableView.hideSkeleton()
    }
}
