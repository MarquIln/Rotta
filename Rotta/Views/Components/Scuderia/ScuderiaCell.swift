


import UIKit

class ScuderiaCell: UITableViewCell {
    
    weak var delegate: ScuderiaCellDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsRows
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .fillsSelector
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(chevronImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronTapped))
        chevronImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    @objc private func chevronTapped() {
        delegate?.didTapChevron(in: self)
    }
    
    func configure(with scuderia: ScuderiaTableViewController.Scuderia) {
        nameLabel.text = scuderia.name
        logoImageView.image = UIImage(named: scuderia.imageName)
    }
}

protocol ScuderiaCellDelegate: AnyObject {
    func didTapChevron(in cell: ScuderiaCell)
}







//import UIKit
//
//
//class ScuderiaCell: UITableViewCell {
//
//    weak var delegate: ScuderiaCellDelegate?
//
//    lazy var containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .fillsRows
//        view.layer.cornerRadius = 12
//        return view
//    }()
//
//    lazy var iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 0
//        imageView.backgroundColor = .clear 
//        return imageView
//    }()
//
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.textColor = .white
//        label.text = "Scuderia"
//        return label
//    }()
//
//    lazy var chevronImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.tintColor = .fillsSelector
//        imageView.isUserInteractionEnabled = true
//        return imageView
//    }()
//
//    @objc private func chevronTapped() {
//        print("chevron tapped")
//        delegate?.didTapChevron(in: self)
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupCell() {
//        backgroundColor = .clear
//        selectionStyle = .none
//
//        contentView.addSubview(containerView)
//        containerView.addSubview(iconImageView)
//        containerView.addSubview(titleLabel)
//        containerView.addSubview(chevronImageView)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronTapped))
//        chevronImageView.addGestureRecognizer(tapGesture)
//
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//
//            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
//            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            iconImageView.widthAnchor.constraint(equalToConstant: 40),
//            iconImageView.heightAnchor.constraint(equalToConstant: 40),
//
//            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
//            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//
//            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
//            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
//            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
//        ])
//    }
//
//    func configure(title: String, image: UIImage? = nil) {
//        titleLabel.text = title
//        iconImageView.image = image
//    }
//}
//
//protocol ScuderiaCellDelegate: AnyObject {
//    func didTapChevron(in cell: ScuderiaCell)
//}
//
