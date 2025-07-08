//
//  AppleLoginVC.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit
import AuthenticationServices

class AppleLoginVC: UIViewController {
    let appleCredential: ASAuthorizationAppleIDCredential
    var availableDrivers: [DriverModel] = []
    var selectedDriver: DriverModel?
    var selectedFormula: FormulaType = .formula2
    var selectedProfileImage: UIImage?
    
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Complete Your Profile"
        titleLabel.font = Fonts.Subtitle1
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Tell us a bit more about yourself"
        subtitleLabel.font = Fonts.Subtitle1
        subtitleLabel.alpha = 0.8
        return subtitleLabel
    }()

    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var principalView: UIView = {
        let principalView = UIView()
        principalView.translatesAutoresizingMaskIntoConstraints = false
        principalView.backgroundColor = .backgroundPrimary
        principalView.layer.cornerRadius = 30
        return principalView
    }()

    lazy var nameComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "How would you like to be called?"
        view.placeholder = "Your name"
        view.delegate = self
        return view
    }()

    lazy var emailComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "Email"
        view.placeholder = "your.email@example.com"
        view.delegate = self
        return view
    }()

    lazy var formulaSelectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "Preferred Formula"
        label.font = Fonts.Subtitle1
        label.textColor = .labelsPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var formulaSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Formula 2", "Formula 3", "F1 Academy"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(formulaChanged), for: .valueChanged)
        return control
    }()

    lazy var driverSelectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite Driver (optional)"
        label.font = Fonts.Subtitle1
        label.textColor = .labelsPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var driverPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameComponent, emailComponent, profileImageContainerView, formulaSelectionView, driverSelectionView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()

    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Complete Setup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .formulaRace
        button.layer.cornerRadius = 12
        button.titleLabel?.font = Fonts.Subtitle1
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy var profileImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile Picture (optional)"
        label.font = Fonts.Subtitle1
        label.textColor = .labelsPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImageSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to add a profile picture"
        label.font = Fonts.Subtitle1
        label.textColor = .labelsPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImageStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageLabel, profileImageSubLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var profileImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImageHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, profileImageStackView])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(appleCredential: ASAuthorizationAppleIDCredential) {
        self.appleCredential = appleCredential
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        
        loadDrivers()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func loadDrivers() {
        Task {
            let drivers = await Database.shared.getDrivers(for: selectedFormula)
            self.availableDrivers = drivers
            DispatchQueue.main.async {
                self.driverPickerView.reloadAllComponents()
            }
        }
    }

    @objc private func formulaChanged() {
        switch formulaSegmentedControl.selectedSegmentIndex {
        case 0:
            selectedFormula = .formula2
        case 1:
            selectedFormula = .formula3
        case 2:
            selectedFormula = .f1Academy
        default:
            selectedFormula = .formula2
        }
        loadDrivers()
    }

    @objc private func completeButtonTapped() {
        guard let name = nameComponent.textField.text, !name.isEmpty else {
            showAlert(message: "Please enter your name")
            return
        }

        let email = emailComponent.textField.text?.isEmpty == false ? emailComponent.textField.text : nil
        
        Task {
            do {
                let user = try await UserService.shared.registerAppleUser(
                    credential: appleCredential,
                    customName: name,
                    customEmail: email,
                    favoriteDriver: selectedDriver?.name,
                    preferredFormula: selectedFormula
                )

                if let selectedImage = selectedProfileImage,
                   let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                    do {
                        try await UserService.shared.updateUserProfileImage(imageData)
                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name("ProfileImageUpdated"), object: nil)
                        }
                    } catch {
                    }
                }
                
                try await Task.sleep(nanoseconds: 500_000_000)
                
                if UserService.shared.getLoggedUser() != nil {
                    DispatchQueue.main.async {
                        self.navigateToMainTab()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Login verification failed. Please try again.")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(message: "Failed to complete setup. Please try again.")
                }
            }
        }
    }

    @objc private func profileImageTapped() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose an option", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Select Photo", style: .default) { _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true)
        })
        
        if selectedProfileImage != nil {
            actionSheet.addAction(UIAlertAction(title: "Remove Photo", style: .destructive) { _ in
                self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
                self.profileImageView.tintColor = .systemGray3
                self.profileImageView.layer.borderColor = UIColor.systemGray4.cgColor
                self.selectedProfileImage = nil
                self.profileImageSubLabel.text = "Tap to add a profile picture"
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func navigateToMainTab() {
        if let loggedUser = UserService.shared.getLoggedUser() {
            
            let mainTabBarController = MainTabController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = mainTabBarController
                window.makeKeyAndVisible()
                
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
                
            } else {
                showAlert(message: "Navigation error. Please restart the app.")
            }
        } else {
            showAlert(message: "Login verification failed. Please try again.")
        }
    }
}

extension AppleLoginVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            profileImageView.image = image
            profileImageView.tintColor = nil
            profileImageView.layer.borderColor = UIColor.formulaRace.cgColor
            self.selectedProfileImage = image
            profileImageSubLabel.text = "Profile picture selected"
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
