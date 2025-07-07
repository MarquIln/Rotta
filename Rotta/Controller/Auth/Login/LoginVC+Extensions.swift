//
//  LoginVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit

extension LoginVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            textField.layer.borderColor = UIColor.raceFormula2.cgColor
        } else {
            textField.layer.borderColor = UIColor.raceFormula2.cgColor
        }
    }

    func validateLogin() -> Bool {
        return true
    }

    func showLoginError() {
        emailAndPasswordErrorLabel.isHidden = false
        emailComponent.textField.layer.borderColor = UIColor.red.cgColor
        passwordComponent.textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func clearLoginErrors() {
        emailComponent.textField.text = ""
        passwordComponent.textField.text = ""
        emailAndPasswordErrorLabel.isHidden = true
    }
}




extension LoginVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(principalView)
        headerView.addSubview(headerStackView)
        principalView.addSubview(mainStackView)
        principalView.addSubview(forgotPassword)
        principalView.addSubview(emailAndPasswordErrorLabel)
        principalView.addSubview(actionButtonsStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            headerStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 98
            ),
            headerStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            headerStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),

            headerView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            headerView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 0
            ),
            headerView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 0
            ),
            headerView.heightAnchor.constraint(equalToConstant: 281),

            principalView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: -20
            ),
            principalView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 0
            ),
            principalView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 0
            ),
            principalView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: 0
            ),

            mainStackView.topAnchor.constraint(
                equalTo: principalView.topAnchor,
                constant: 20
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            
            forgotPassword.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            
            forgotPassword.topAnchor.constraint(
                equalTo: mainStackView.bottomAnchor,
                constant: 16
            ),
            
            emailAndPasswordErrorLabel.topAnchor.constraint(
                equalTo: forgotPassword.bottomAnchor,
                constant: 53
            ),
            
            emailAndPasswordErrorLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            
            emailAndPasswordErrorLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            

            actionButtonsStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -50
            ),
            actionButtonsStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            actionButtonsStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),

            loginButton.heightAnchor.constraint(equalToConstant: 46),
            createAccountButton.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
}
