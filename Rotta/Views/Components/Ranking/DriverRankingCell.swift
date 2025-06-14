//
//  DriverRankingCell.swift
//  Rotta
//
//  Created by Marcos on 13/06/25.
//

import UIKit
import CloudKit

class DriverRankingCell: UITableViewCell {
    static let reuseIdentifier = "DriverRankingCell"
    
    let cloudKitModel = CloudKitModel.shared
    
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
    
    lazy var scuderiaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var driverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [positionLabel, driverImageView, nameLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var performanceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pointsLabel, scuderiaLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStackView, performanceStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with driver: CKRecord, position: Int, cellIndex: Int) {
        positionLabel.text = "\(position)"
        
        let fullName = driver.value(forKey: "fullName") as? String ?? ""
        nameLabel.text = formatDriverName(fullName)
        
        let points = driver.value(forKey: "points") as? Int ?? 0
        pointsLabel.text = "\(points)"
        
        if let scuderia = driver.value(forKey: "scuderia") as? String {
            scuderiaLabel.text = scuderia
        }
        
        driverImageView.image = UIImage(systemName: "person.circle.fill")
        driverImageView.tintColor = .systemGray3
        
        setupBackgroundColor(for: cellIndex)
    }
    
    private func setupBackgroundColor(for cellIndex: Int) {
        if cellIndex % 2 == 0 {
            backgroundColor = UIColor(named: "white4")
        } else {
            backgroundColor = UIColor(named: "white5")
        }
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
            pointsLabel.widthAnchor.constraint(equalToConstant: 40),
            scuderiaLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
