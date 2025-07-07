//
//  TopThreeScuderiasCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit
import SkeletonView

class ScuderiaView: UIView {
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView: UIImageView = {
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
        let stack = UIStackView(arrangedSubviews: [imageView, positionLabel, nameLabel, pointsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    func configure(with model: ScuderiaModel, rank: Int) {
        positionLabel.text = "\(rank)"
        nameLabel.text = model.name
        pointsLabel.text = "\(Int(model.points)) pontos"
        imageView.image = UIImage(named: model.logo)
        if rank == 1 {
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
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
        imageView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        pointsLabel.isSkeletonable = true

        positionLabel.linesCornerRadius = 8
        nameLabel.linesCornerRadius = 6
        pointsLabel.linesCornerRadius = 6
        imageView.skeletonCornerRadius = 50
    }
}

extension ScuderiaView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
        ])
    }
}