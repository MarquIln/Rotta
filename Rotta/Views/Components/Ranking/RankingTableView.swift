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
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(DriverRankingCell.self, forCellReuseIdentifier: "DriverRankingCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension RankingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfDrivers() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DriverRankingCell", for: indexPath) as? DriverRankingCell,
              let driver = delegate?.driver(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let position = indexPath.row + 1
        cell.configure(with: driver, position: position)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RankingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        delegate?.didScrollWithPosition(currentPosition, difference: 0)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.willBeginDragging(at: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.didEndDecelerating(at: scrollView.contentOffset.y)
    }
}
