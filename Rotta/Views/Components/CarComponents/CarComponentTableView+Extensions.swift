//
//  CarComponentTableView+Extensions.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

extension CarComponentTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carComponents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarComponentCell.reuseIdentifier, for: indexPath) as? CarComponentCell else {
            return UITableViewCell()
        }
        let carComponent = carComponents[indexPath.row]
        cell.config(with: carComponent, cellIndex: indexPath.row)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CarComponentTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedComponent = carComponents[indexPath.row]
        
        // Notificar o controller sobre a seleção
        NotificationCenter.default.post(
            name: NSNotification.Name("CarComponentSelected"),
            object: selectedComponent
        )
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

extension CarComponentTableView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
