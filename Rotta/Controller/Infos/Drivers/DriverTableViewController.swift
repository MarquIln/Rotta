//
//  DriverTableViewController.swift
//  Rotta
//
//  Created by sofia leitao on 21/06/25.
//

import UIKit

class DriverTableViewController: UIViewController {
    var drivers: [DriverModel] = []
    let database = Database.shared

    private lazy var headerView: DriverHeader = {
        let headerView = DriverHeader()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private lazy var driverTableView: DriverTableView = {
        let tableView = DriverTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()

    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addGradientGlossary()
        loadDrivers()
    }
    
    private func loadDrivers() {
        Task {
            drivers = await database.getAllDrivers()
            
            await MainActor.run {
                self.driverTableView.configure(with: drivers)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(
            UIImage(systemName: "chevron.left.circle.fill"),
            for: .normal
        )
        backButton.tintColor = .rottaYellow
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 16
        backButton.clipsToBounds = true
        backButton.addTarget(
            self,
            action: #selector(customBackTapped),
            for: .touchUpInside
        )
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        return backButton
    }()

    @objc private func customBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func configure(with drivers: [DriverModel]) {
        self.drivers = drivers
        driverTableView.configure(with: drivers)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Pilotos"
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(gradientView)
        view.addSubview(headerView)
        view.addSubview(driverTableView)

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

extension DriverTableViewController: UITableViewDelegate, UITableViewDataSource, DriverCellDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "DriverCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DriverCell ?? DriverCell(style: .default, reuseIdentifier: identifier)
        let driver = drivers[indexPath.row]
        
        cell.config(with: driver, cellIndex: indexPath.row)
        cell.delegate = self
        return cell
    }

    func didTapChevron(in cell: DriverCell) {
        print("Chevron da célula tocado")
//        let vc = DriverDetailsViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
}




