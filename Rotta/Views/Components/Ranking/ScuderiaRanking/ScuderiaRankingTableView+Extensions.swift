//
//  RankingTableView+Extensions.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

extension ScuderiaRankingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scuderias.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScuderiaRankingCell.reuseIdentifier, for: indexPath) as? ScuderiaRankingCell else {
            return UITableViewCell()
        }
        let scuderia = scuderias[indexPath.row]
        let position = indexPath.row + 1
        cell.config(with: scuderia, position: position, cellIndex: indexPath.row)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        } else {
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ScuderiaRankingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scuderia = scuderias[indexPath.row]
        delegate?.rankingTableView(self, didSelect: scuderia)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        impactFeedback.prepare()
        lastScrollPosition = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.y
        let diff = abs(current - lastScrollPosition)
        let now = CACurrentMediaTime()
        if diff >= scrollThreshold && now - lastFeedbackTime > 0.03 {
            impactFeedback.impactOccurred(intensity: 1)
            lastScrollPosition = current
            impactFeedback.prepare()
            lastFeedbackTime = now
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastScrollPosition = scrollView.contentOffset.y
    }
}

extension ScuderiaRankingTableView: ViewCodeProtocol {
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
