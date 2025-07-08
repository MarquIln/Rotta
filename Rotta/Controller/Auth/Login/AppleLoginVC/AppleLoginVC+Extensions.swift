//
//  AppleLoginVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit
import AuthenticationServices

extension AppleLoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameComponent.textField {
            emailComponent.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension AppleLoginVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableDrivers.count + 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "No preference"
        }
        return availableDrivers[row - 1].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            selectedDriver = nil
        } else {
            selectedDriver = availableDrivers[row - 1]
        }
    }
}

extension AppleLoginVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(principalView)
        headerView.addSubview(headerStackView)
        principalView.addSubview(mainStackView)
        principalView.addSubview(completeButton)

        formulaSelectionView.addSubview(formulaLabel)
        formulaSelectionView.addSubview(formulaSegmentedControl)
        
        driverSelectionView.addSubview(driverLabel)
        driverSelectionView.addSubview(driverPickerView)
        
        profileImageContainerView.addSubview(profileImageHorizontalStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),

            headerStackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerStackView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 20),
            headerStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),

            principalView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            principalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            principalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            principalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainStackView.topAnchor.constraint(equalTo: principalView.topAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: principalView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: principalView.trailingAnchor, constant: -16),

            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.leadingAnchor.constraint(equalTo: principalView.leadingAnchor, constant: 16),
            completeButton.trailingAnchor.constraint(equalTo: principalView.trailingAnchor, constant: -16),
            completeButton.heightAnchor.constraint(equalToConstant: 50),
            
            formulaLabel.topAnchor.constraint(equalTo: formulaSelectionView.topAnchor),
            formulaLabel.leadingAnchor.constraint(equalTo: formulaSelectionView.leadingAnchor),
            formulaLabel.trailingAnchor.constraint(equalTo: formulaSelectionView.trailingAnchor),

            formulaSegmentedControl.topAnchor.constraint(equalTo: formulaLabel.bottomAnchor, constant: 8),
            formulaSegmentedControl.leadingAnchor.constraint(equalTo: formulaSelectionView.leadingAnchor),
            formulaSegmentedControl.trailingAnchor.constraint(equalTo: formulaSelectionView.trailingAnchor),
            formulaSegmentedControl.bottomAnchor.constraint(equalTo: formulaSelectionView.bottomAnchor),
            formulaSegmentedControl.heightAnchor.constraint(equalToConstant: 32),
        
            driverLabel.topAnchor.constraint(equalTo: driverSelectionView.topAnchor),
            driverLabel.leadingAnchor.constraint(equalTo: driverSelectionView.leadingAnchor),
            driverLabel.trailingAnchor.constraint(equalTo: driverSelectionView.trailingAnchor),

            driverPickerView.topAnchor.constraint(equalTo: driverLabel.bottomAnchor, constant: 8),
            driverPickerView.leadingAnchor.constraint(equalTo: driverSelectionView.leadingAnchor),
            driverPickerView.trailingAnchor.constraint(equalTo: driverSelectionView.trailingAnchor),
            driverPickerView.bottomAnchor.constraint(equalTo: driverSelectionView.bottomAnchor),
            driverPickerView.heightAnchor.constraint(equalToConstant: 120),
            
            profileImageHorizontalStack.topAnchor.constraint(equalTo: profileImageContainerView.topAnchor),
            profileImageHorizontalStack.leadingAnchor.constraint(equalTo: profileImageContainerView.leadingAnchor),
            profileImageHorizontalStack.trailingAnchor.constraint(equalTo: profileImageContainerView.trailingAnchor),
            profileImageHorizontalStack.bottomAnchor.constraint(equalTo: profileImageContainerView.bottomAnchor),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
