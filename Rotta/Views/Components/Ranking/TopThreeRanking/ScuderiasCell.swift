//
//  TopThreeScuderiasCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class ScuderiasCell: UICollectionViewCell {
    static let reuseIdentifier = "TopThreeScuderiasCell"

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, positionLabel, nameLabel, pointsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.clipsToBounds = true
        setupConstraints()
    }

    func configure(with model: ScuderiaModel, rank: Int) {
        positionLabel.text = "\(rank)"
        nameLabel.text = model.name
        pointsLabel.text = "\(model.points) pontos"
        imageView.image = UIImage(named: model.logo)
    }
}

extension ScuderiasCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
