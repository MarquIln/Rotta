//
//  RankingVC.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class ScuderiaRankingVC: UIViewController, ScuderiaRankingTableViewDelegate, FormulaFilterable {
    func rankingTableView(_ view: ScuderiaRankingTableView, didSelect scuderia: ScuderiaModel) {
        let detailsVC = ScuderiaDetailsViewController()
        detailsVC.scuderia = scuderia
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    var scuderias: [ScuderiaModel] = []
    let database = Database.shared
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0
    private var currentFormula: FormulaType = .formula2

    lazy var rankingTableView: ScuderiaRankingTableView = {
        let view = ScuderiaRankingTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true

        return view
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)

        let config = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .regular
        )
        let image = UIImage(
            systemName: "xmark.circle.fill",
            withConfiguration: config
        )
        button.setImage(image, for: .normal)

        button.tintColor = .rottaYellow
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(
            self,
            action: #selector(didTapBackButton),
            for: .touchUpInside
        )

        return button
    }()

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        currentFormula = Database.shared.getSelectedFormula()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton
        )
        navigationController?.isNavigationBarHidden = false

        navigationItem.title = "Scuderia Ranking"

        rankingTableView.delegate = self

        loadScuderias()
        setup()
        impactFeedback.prepare()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradientCardInfos()
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    private func loadScuderias() {
        Task {
            scuderias = await database.getScuderias(for: currentFormula)

            scuderias.sort { $0.points > $1.points }
            await MainActor.run {
                self.rankingTableView.configure(with: scuderias)
            }
        }
    }
    
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        loadScuderias()
    }
}

extension ScuderiaRankingVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.view.addGradientCardInfos()
        }
    }
}

extension ScuderiaRankingVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
            UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
