//
//  TopThreeRankingCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class DriversCell: UICollectionViewCell {
    static let reuseIdentifier = "DriversCell"
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var driverImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemGray3
        return image
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.FootnoteEmphasized
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.FootnoteRegular
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [driverImageView, positionLabel, nameLabel, pointsLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with driver: DriverModel, rank: Int) {
        positionLabel.text = "\(rank)"
        let parts = driver.name.split(separator: " ")
        nameLabel.text = parts.count >= 2 ? "\(parts.first!.prefix(1)). \(parts.last!)" : driver.name
        pointsLabel.text = "\(driver.points) points"
    }
}

// MARK: - ViewCodeProtocol
extension DriversCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            driverImageView.widthAnchor.constraint(equalToConstant: 60),
            driverImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
