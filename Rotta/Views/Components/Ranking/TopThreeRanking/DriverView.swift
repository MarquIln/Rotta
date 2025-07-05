//
//  TopThreeRankingCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit
import SkeletonView

class DriverView: UIView {
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var driverImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
        setupSkeleton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSkeleton() {
        isSkeletonable = true
        stackView.isSkeletonable = true
        positionLabel.isSkeletonable = true
        driverImageView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        pointsLabel.isSkeletonable = true
        
        // Configurar propriedades específicas
        positionLabel.linesCornerRadius = 8
        nameLabel.linesCornerRadius = 6
        pointsLabel.linesCornerRadius = 6
        driverImageView.skeletonCornerRadius = 40
    }

    func configure(with driver: DriverModel, rank: Int) {
        positionLabel.text = "\(rank)"
        let parts = driver.name.split(separator: " ")
        nameLabel.text = parts.count >= 2 ? "\(parts.first!.prefix(1)). \(parts.last!)" : driver.name
        pointsLabel.text = "\(driver.points) pontos"
        driverImageView.image = UIImage(named: driver.photo!) ?? UIImage(systemName: "person.fill")
        if rank == 1 {
            driverImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            driverImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        } else {
            driverImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            driverImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        self.layoutIfNeeded()
        
        driverImageView.layer.cornerRadius = driverImageView.frame.height / 2
        driverImageView.clipsToBounds = true
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
