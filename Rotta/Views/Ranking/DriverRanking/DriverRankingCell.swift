//
//  DriverRankingCell.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit

class DriverRankingCell: UITableViewCell {
    static let reuseIdentifier = "DriverRankingCell"
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textColor = .white
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var scuderiaLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var driverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var driverFlag: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        
        return label
    }()
    
    private lazy var driverStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, driverFlag])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillProportionally

        return stack
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [positionLabel, driverImageView, driverStackView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stack
    }()
    
    private lazy var performanceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pointsLabel, scuderiaLabel])
        stack.axis = .horizontal
        stack.spacing = 40
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStackView, performanceStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        driverImageView.layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with driver: DriverModel, position: Int, cellIndex: Int) {
        positionLabel.text = "\(position)"
        nameLabel.text = formatDriverName(driver.name)
        driverFlag.text = driver.country?.getCountryFlag()
        pointsLabel.text = "\(driver.points)"
        driverImageView.image = UIImage(named: driver.photo!) ?? UIImage(systemName: "person.fill")
        scuderiaLabel.image = UIImage(named: driver.scuderiaLogo!) ?? UIImage(systemName: "flag.fill")
    }
    
    private func formatDriverName(_ fullName: String) -> String {
        let components = fullName.components(separatedBy: " ").filter { !$0.isEmpty }
        guard components.count >= 2, let firstName = components.first, let lastName = components.last else { 
            return fullName 
        }
        
        let firstNameLetter = String(firstName.prefix(1))
        return "\(firstNameLetter). \(lastName)"
    }
}

// MARK: - ViewCodeProtocol
extension DriverRankingCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            positionLabel.widthAnchor.constraint(equalToConstant: 34),
            driverImageView.widthAnchor.constraint(equalToConstant: 28),
            driverImageView.heightAnchor.constraint(equalToConstant: 28),
            scuderiaLabel.widthAnchor.constraint(equalToConstant: 56),
            scuderiaLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
