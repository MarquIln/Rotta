//
//  RankingTableView.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit

protocol RankingTableViewDelegate: AnyObject {
    func numberOfDrivers() -> Int
    func driver(at index: Int) -> Driver
    func didScrollWithPosition(_ position: CGFloat, difference: CGFloat)
    func willBeginDragging(at position: CGFloat)
    func didEndDecelerating(at position: CGFloat)
}

class RankingTableView: UIView {
    weak var delegate: RankingTableViewDelegate?
    
    var showOnlyTopThree: Bool = true {
      didSet { tableView.reloadData() }
    }
    
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
        stack.backgroundColor = .end
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
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(DriverRankingCell.self, forCellReuseIdentifier: DriverRankingCell.reuseIdentifier)
        
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
    
    func reloadData() {
        tableView.reloadData()
    }
}

