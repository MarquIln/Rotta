//
//  RankingTableView+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

extension RankingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfDrivers() ?? 0
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverRankingCell.reuseIdentifier, for: indexPath) as? DriverRankingCell,
              let driver = delegate?.driver(at: indexPath.row) else {
            return UITableViewCell()
        }
        let position = indexPath.row + 1
        
        cell.config(with: driver, position: position, cellIndex: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}

extension RankingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

extension RankingTableView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(headerStack)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerStack.heightAnchor.constraint(equalToConstant: 38),

            tableView.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
