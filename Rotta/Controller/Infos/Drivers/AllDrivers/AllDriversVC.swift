//
//  DriverTableViewController.swift
//  Rotta
//
//  Created by sofia leitao on 21/06/25.
//

import UIKit

class AllDriversVC: UIViewController {
    var drivers: [DriverModel] = []
    let database = Database.shared
    private var currentFormula: FormulaType = .formula2

    lazy var headerView: DriverHeader = {
        let headerView = DriverHeader()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    lazy var driverTableView: DriverTableView = {
        let tableView = DriverTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        
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
        setup()
        currentFormula = Database.shared.getSelectedFormula()

        addGradientGlossary()
        loadDrivers()
        FormulaColorManager.shared.addDelegate(self)
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
    
    private func loadDrivers() {
        Task {
            drivers = await database.getDrivers(for: currentFormula)
            
            await MainActor.run {
                self.driverTableView.configure(with: drivers)
            }
        }
    }
    
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        loadDrivers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
}
