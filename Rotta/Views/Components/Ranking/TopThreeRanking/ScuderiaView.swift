//
//  TopThreeScuderiasCell.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class ScuderiaView: UIView {
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        return image
    }()

    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.FootnoteEmphasized
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.FootnoteRegular
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .purple
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, positionLabel, nameLabel, pointsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(with model: ScuderiaModel, rank: Int) {
        positionLabel.text = "\(rank)"
        nameLabel.text = model.name
        pointsLabel.text = "\(model.points) pontos"
        imageView.image = UIImage(systemName: "person.circle.fill")
        if rank == 1 {
            imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        } else {
            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
}

extension ScuderiaView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
