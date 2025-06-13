//
//  GlossaryButton.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 11/06/25.
//
import UIKit
class CardInfosButton: UIButton {
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        self.backgroundColor = .cardInfosBackground
        cardTitleLabel.text = title
        cardSubtitleLabel.text = subtitle
        setup()
        addGradientCardInfos()
    }
    
    lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = Fonts.Title1
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cardSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = Fonts.BodyRegular
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackTitleSubtitle: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardTitleLabel, cardSubtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .categoryInfos
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addGradientCardInfos(){
        DispatchQueue.main.async {
            self.gradientView.addGradientCardInfos()
        }
    }

}

extension CardInfosButton: ViewCodeProtocol {
    func setup() {
        self.layer.cornerRadius = 37
        clipsToBounds = true
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(imageBackground)
        addSubview(gradientView)
        addSubview(stackTitleSubtitle)
        self.frame = imageBackground.bounds
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gradientView.topAnchor.constraint(equalTo: imageBackground.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor),
            
            stackTitleSubtitle.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -25),
            stackTitleSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            stackTitleSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
        ])
    }
}
