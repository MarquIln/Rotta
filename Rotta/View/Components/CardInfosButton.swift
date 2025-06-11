//
//  GlossaryButton.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 11/06/25.
//
import UIKit
class CardInfosButton: UIButton {
    var image: String
    var title: String
    var subtitle: String
    
    init(image: String, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        self.backgroundColor = .cardInfosBackground
        cardTitleLabel.text = title
        cardSubtitleLabel.text = subtitle
    }
    
    lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    lazy var cardSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CardInfosButton: ViewCodeProtocol {
    func setup() {
        
    }
    func addSubviews() {
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
