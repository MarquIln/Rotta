//
//  RankingTableView.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit

class ScuderiaRankingTableView: UIView {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    var lastScrollPosition: CGFloat = 0
    let scrollThreshold: CGFloat = 20
    var lastFeedbackTime: CFTimeInterval = 0
    
    weak var delegate: ScuderiaRankingTableViewDelegate?

    var scuderias: [ScuderiaModel] = []

    lazy var scuderiaLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.text = "Scuderia"
        label.textAlignment = .center
        label.textColor = .white
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return label
    }()

    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textAlignment = .center
        label.text = "Pontos"
        label.textColor = .white

        return label
    }()

    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [scuderiaLabel, pointsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.backgroundColor = FormulaColorManager.shared.raceColor
        stack.alignment = .fill
        stack.layer.cornerRadius = 12
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true

        stack.layer.maskedCorners = [
             .layerMinXMinYCorner,
             .layerMaxXMinYCorner
         ]
         stack.layer.masksToBounds = true

        return stack
    }()

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.backgroundView = nil
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 8
        table.layer.maskedCorners = [.layerMinXMinYCorner]
        
        table.register(ScuderiaRankingCell.self, forCellReuseIdentifier: ScuderiaRankingCell.reuseIdentifier)

        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        impactFeedback.prepare()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        impactFeedback.prepare()
        setup()
    }
        
    func configure(with scuderias: [ScuderiaModel]) {
        self.scuderias = scuderias
        tableView.reloadData()
    }
}

protocol ScuderiaRankingTableViewDelegate: AnyObject {
    func rankingTableView(_ view: ScuderiaRankingTableView, didSelect scuderia: ScuderiaModel)
}

extension ScuderiaRankingTableView: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.headerStack.backgroundColor = FormulaColorManager.shared.raceColor
        }
    }
}
