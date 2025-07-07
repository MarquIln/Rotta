//
//  DriverRankingCell.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit
import CloudKit

class ScuderiaRankingCell: UITableViewCell {
    static let reuseIdentifier = "ScuderiaRankingCell"
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Subtitle2
        label.textColor = .white
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var scuderiaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [positionLabel, scuderiaImageView, nameLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStackView, pointsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with scuderia: ScuderiaModel, position: Int, cellIndex: Int) {
        positionLabel.text = "\(position)"
        nameLabel.text = scuderia.name
        pointsLabel.text = "\(Int(scuderia.points))"
        scuderiaImageView.image = UIImage(named: scuderia.logo) ?? UIImage(systemName: "person.fill")
    }
}

// MARK: - ViewCodeProtocol
extension ScuderiaRankingCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            positionLabel.widthAnchor.constraint(equalToConstant: 34),
            scuderiaImageView.widthAnchor.constraint(equalToConstant: 36),
            scuderiaImageView.heightAnchor.constraint(equalToConstant: 20),
//            pointsLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}
