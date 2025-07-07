//
//  PasswordTextField.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

class PasswordTextField: UIView {
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .systemRed
        view.image = UIImage(systemName: "xmark.circle.fill")
        return view
    }()
    
    lazy var requirementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProRounded-Semibold", size: 14)
        label.textColor = .label
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, requirementLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    var requirementText: String? {
        didSet {
            requirementLabel.text = requirementText
        }
    }
    
    var fulfilled: Bool = false {
        didSet {
            updateIcon()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateIcon() {
        let imageName = fulfilled ? "checkmark" : "xmark"
        let tintColor = fulfilled ? UIColor.systemGreen : UIColor.systemRed
        
        iconImageView.image = UIImage(systemName: imageName)
        iconImageView.tintColor = tintColor
    }
}

extension PasswordTextField: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 17),
            iconImageView.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
}
