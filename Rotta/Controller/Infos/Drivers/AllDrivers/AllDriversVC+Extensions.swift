//
//  AllDriversVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 08/07/25.
//

import UIKit

extension AllDriversVC: UITableViewDelegate, UITableViewDataSource, DriverCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "DriverCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DriverCell ?? DriverCell(style: .default, reuseIdentifier: identifier)
        let driver = drivers[indexPath.row]
        
        cell.config(with: driver, cellIndex: indexPath.row)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }

    func didTapChevron(in cell: DriverCell) {
        let detailsVC = DriverDetailsVC(driver: drivers[cell.tag])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension AllDriversVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.addGradientGlossary()
        }
    }
}

extension AllDriversVC: DriverTableViewDelegate {
    func driverTableView(_ tableView: DriverTableView, didSelectDriver driver: DriverModel) {
        let detailsVC = DriverDetailsVC(driver: driver)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension AllDriversVC: ViewCodeProtocol {
    func addSubviews() {
        view.backgroundColor = .systemBackground
        title = "Pilotos"
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(gradientView)
        view.addSubview(headerView)
        view.addSubview(driverTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            driverTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            driverTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            driverTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            driverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
