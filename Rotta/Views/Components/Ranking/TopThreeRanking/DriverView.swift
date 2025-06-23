//
//  TopThreeRankingCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class DriverView: UIView {
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
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
        pointsLabel.text = "\(driver.points) pontos"
        driverImageView.image = UIImage(systemName: "person.circle.fill")
        if rank == 1 {
            driverImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            driverImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        } else {
            driverImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            driverImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
}

// MARK: - ViewCodeProtocol
extension DriverView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
