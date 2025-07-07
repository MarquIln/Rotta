//
//  NamedTextField.swift
//  LoginFlowViewCode
//
//  Created by Marcos on 02/05/25.
//

import UIKit

class NamedTextField: UIView {
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        label.textColor = .labelsPrimary
        return label
    }()

    lazy var textField: UITextField = {
        var textField = PaddedTextField()
        textField.backgroundColor = .backgroundSecondary
        textField.layer.cornerRadius = 8
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        textField.textColor = .labelsPrimary
        return textField
    }()

    lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [label, textField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8

        return stack
    }()
    
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get {
            textField.autocapitalizationType
        }
        set {
            textField.autocapitalizationType = newValue
        }
    }
    
    var delegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("erro")
    }
}

extension NamedTextField: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
}
