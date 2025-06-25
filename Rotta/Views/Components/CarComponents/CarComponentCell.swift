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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var componentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.tintColor = .white
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
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.3, green: 0.35, blue: 0.45, alpha: 0.9)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with component: ComponentModel, cellIndex: Int) {
        titleLabel.text = component.name
        
        // Usar ícones do sistema baseado no nome do componente
        let iconName: String
        switch component.name?.lowercased() {
        case let name where name?.contains("aerodinâmica") == true:
            iconName = "airplane"
        case let name where name?.contains("chassi") == true:
            iconName = "car.fill"
        case let name where name?.contains("motor") == true:
            iconName = "engine.combustion.fill"
        case let name where name?.contains("pneus") == true:
            iconName = "circle.fill"
        case let name where name?.contains("câmbio") == true:
            iconName = "gearshape.fill"
        case let name where name?.contains("suspensão") == true:
            iconName = "line.3.crossed.swirl.circle.fill"
        case let name where name?.contains("freios") == true:
            iconName = "stop.circle.fill"
        default:
            iconName = "car.fill"
        }
        
        componentImage.image = UIImage(systemName: iconName)
    }
}

// MARK: - ViewCodeProtocol
extension CarComponentCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        contentView.backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Stack view constraints
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Component image size
            componentImage.widthAnchor.constraint(equalToConstant: 50),
            componentImage.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

