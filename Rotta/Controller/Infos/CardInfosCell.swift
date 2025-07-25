//
//  CardInfosCell.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class CardInfosCell: UICollectionViewCell {
    static let identifier = "CardInfosCell"

    let cardButton: CardInfosButton = {
        let button = CardInfosButton(title: "", subtitle: "", image: UIImage())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cardButtonPublic: CardInfosButton {
        return cardButton
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardButton)

        NSLayoutConstraint.activate([
            cardButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, subtitle: String, image: UIImage, tag: Int, target: Any, action: Selector) {
        cardButton.cardTitleLabel.text = title
        cardButton.cardSubtitleLabel.text = subtitle
        cardButton.imageBackground.image = image
        cardButton.tag = tag
        cardButton.removeTarget(nil, action: nil, for: .allEvents)
        cardButton.addTarget(target, action: action, for: .touchUpInside)
    }

}
