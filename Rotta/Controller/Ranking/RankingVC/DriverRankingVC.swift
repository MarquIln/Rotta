//
//  RankingVC.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class DriverRankingVC: UIViewController, DriverRankingTableViewDelegate, FormulaFilterable {
    func rankingTableView(_ view: DriverRankingTableView, didSelect driver: DriverModel) {
        let detailVC = DriverPageViewController(driver: driver)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    var drivers: [DriverModel] = []
    let database = Database.shared
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0
    private var currentFormula: FormulaType = .formula2

    lazy var rankingTableView: DriverRankingTableView = {
        let view = DriverRankingTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.delegate = self

        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)

        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)

        button.tintColor = .rottaYellow
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        return button
    }()
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        currentFormula = UserPreferencesManager.shared.getSelectedFormula()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.isNavigationBarHidden = false

        navigationItem.title = "Drivers Ranking"
        
        rankingTableView.delegate = self

        loadDrivers()
        setup()
        impactFeedback.prepare()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradientCardInfos()
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    private func loadDrivers() {
        Task {
            drivers = await database.getDrivers(for: currentFormula)

            drivers.sort { $0.points > $1.points }
            await MainActor.run {
                self.rankingTableView.configure(with: drivers)
            }
        }
    }
    
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        loadDrivers()
    }
}

extension DriverRankingVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.view.addGradientCardInfos()
        }
    }
}

extension DriverRankingVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
