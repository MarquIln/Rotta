//
//  ChampionComponent.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 22/06/25.
//

import UIKit
class ChampionComponent: UIView {
    var champion: String = ""
    
    lazy var championLabel: UILabel = {
        let label = UILabel()
        label.text = "Campeão:"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle2
        return label
    }()
    
    lazy var championVariable: UILabel = {
        let label = UILabel()
        label.text = champion
        label.textColor = .labelsPrimary
        label.font = Fonts.FootnoteRegular
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var heightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [championLabel, championVariable])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 4
        stack.alignment = .firstBaseline
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(champion: String) {
        self.champion = champion
        
        super.init(frame: .zero)
        
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        clipsToBounds = true
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
extension ChampionComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(heightStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            heightStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12),
            heightStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            heightStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}
