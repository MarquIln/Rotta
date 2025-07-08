//
//  ProfileVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            profileImageView.image = image
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                Task {
                    await Database.shared.saveProfileImageData(imageData)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name("ProfileImageUpdated"), object: nil)
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension ProfileVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(profileImageView)
        view.addSubview(editPhotoButton)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(favoriteDriverLabel)
        view.addSubview(currentFormulaLabel)
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profileImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            editPhotoButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -5),
            editPhotoButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -5),
            editPhotoButton.widthAnchor.constraint(equalToConstant: 30),
            editPhotoButton.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            favoriteDriverLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            favoriteDriverLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            favoriteDriverLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            currentFormulaLabel.topAnchor.constraint(equalTo: favoriteDriverLabel.bottomAnchor, constant: 8),
            currentFormulaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            currentFormulaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
