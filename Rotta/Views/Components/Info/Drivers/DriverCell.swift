//
//  DriverCell.swift
//  Rotta
//
//  Created by sofia leitao on 21/06/25.
//
import UIKit


class DriverCell: UITableViewCell {
    static let reuseIdentifier = "DriverCell"
    weak var delegate: DriverCellDelegate?

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsRows
        view.layer.cornerRadius = 12
        return view
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()

    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .fillsSelector
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    @objc private func chevronTapped() {
        print("chevron tapped")
        delegate?.didTapChevron(in: self)
    }

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
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(chevronImageView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronTapped))
        chevronImageView.addGestureRecognizer(tapGesture)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func formatDriverName(_ fullName: String) -> String {
        let components = fullName.components(separatedBy: " ").filter { !$0.isEmpty }
        guard components.count >= 2, let firstName = components.first, let lastName = components.last else {
            return fullName
        }
        
        let firstNameLetter = String(firstName.prefix(1))
        return "\(firstNameLetter). \(lastName)"
    }

    func config(with driver: DriverModel, cellIndex: Int) {
        titleLabel.text = formatDriverName(driver.name)
        iconImageView.image = UIImage(named: driver.photo!) ?? UIImage(systemName: "person.fill")
    }
}

protocol DriverCellDelegate: AnyObject {
    func didTapChevron(in cell: DriverCell)
}


