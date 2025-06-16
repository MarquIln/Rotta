//
//  DriverRankingCell.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit

class DriverRankingCell: UITableViewCell {
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(positionLabel)
        containerView.addSubview(numberLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(countryLabel)
        containerView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            positionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            positionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 40),
            
            numberLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 8),
            numberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            
            countryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            countryLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            pointsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            pointsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pointsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8)
        ])
    }
    
    func configure(with driver: Driver, position: Int) {
        positionLabel.text = "\(position)"
        nameLabel.text = driver.name ?? "Piloto Desconhecido"
        countryLabel.text = driver.country ?? "País não informado"
        pointsLabel.text = "\(Int(driver.points)) pts"
        numberLabel.text = "#\(driver.number)"
        
        switch position {
        case 1:
            containerView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
            positionLabel.textColor = .systemYellow
        case 2:
            containerView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
            positionLabel.textColor = .systemGray
        case 3:
            containerView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.3)
            positionLabel.textColor = .systemOrange
        default:
            containerView.backgroundColor = .systemGray6.withAlphaComponent(0.3)
            positionLabel.textColor = .white
        }
    }
}
