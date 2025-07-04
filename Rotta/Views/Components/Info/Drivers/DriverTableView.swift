//
//  DriverTableView.swift
//  Rotta
//
//  Created by sofia leitao on 21/06/25.
//

import UIKit

protocol DriverTableViewDelegate: AnyObject {
    func driverTableView(_ tableView: DriverTableView, didSelectDriver driver: DriverModel)
}

class DriverTableView: UIView {
    var drivers: [DriverModel] = []
    weak var delegate: DriverTableViewDelegate?
    
    private let fixedCellCount = 20

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(DriverCell.self, forCellReuseIdentifier: "DriverCell")
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
    
    func configure(with drivers: [DriverModel]) {
        self.drivers = drivers
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DriverTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverCell.reuseIdentifier, for: indexPath) as? DriverCell else {
            return UITableViewCell()
        }
        let driver = drivers[indexPath.row]
        cell.config(with: driver, cellIndex: indexPath.row)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DriverTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let driver = drivers[indexPath.row]
        delegate?.driverTableView(self, didSelectDriver: driver)
        print("Driver cell at index \(indexPath.row) selected")
    }
}

