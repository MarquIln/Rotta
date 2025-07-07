//
//  CarComponentCell.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentCell: UITableViewCell {
    static let reuseIdentifier = "CarComponentCell"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Headline
        label.textColor = .white
        return label
    }()
    
    lazy var componentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [componentImage, titleLabel, chevronImageView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 16
        stack.backgroundColor = .fillsRows
        stack.layer.cornerRadius = 12
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with component: ComponentModel, cellIndex: Int) {
        titleLabel.text = component.name
        componentImage.image = UIImage(named: component.image ?? "person.fill")
    }
}

// MARK: - ViewCodeProtocol
extension CarComponentCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            componentImage.widthAnchor.constraint(equalToConstant: 50),
            componentImage.heightAnchor.constraint(equalToConstant: 50),
            
            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

