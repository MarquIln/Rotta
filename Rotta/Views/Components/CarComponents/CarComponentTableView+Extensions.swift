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
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
