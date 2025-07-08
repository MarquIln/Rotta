//
//  RegisterVC.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

class RegisterVC: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create Account"
        label.textColor = .labelsPrimary
        label.textAlignment = .center
        label.font = UIFont(name: "SFProRounded-Bold", size: 34)
        return label
    }()

    lazy var nameComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "Name"
        view.placeholder = "Enter your name"
        view.delegate = self
        return view
    }()

    lazy var emailComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "Email"
        view.placeholder = "abc@abc.com"
        view.delegate = self
        return view
    }()

    lazy var passwordComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "Password"
        view.placeholder = "********"
        view.delegate = self
        return view
    }()

    lazy var favoriteDriverComponent: NamedTextField = {
        let view = NamedTextField()
        view.name = "Favorite Driver"
        view.placeholder = "Enter your favorite driver (optional)"
        view.delegate = self
        return view
    }()

    lazy var switchIcon: UISwitch = {
        let s = UISwitch()
        s.isOn = false
        return s
    }()

    lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I accept the term and privacy policy"
        label.font = UIFont(name: "SFPro-Rounded-Regular", size: 16)
        return label
    }()

    lazy var termsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switchIcon, termsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    lazy var registrationErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont(name: "SFPro-Rounded-Regular", size: 16)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        button.backgroundColor = .raceFormula2
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameComponent, emailComponent, passwordComponent, favoriteDriverComponent, termsStackView, registrationErrorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        passwordComponent.delegate = self
        navigationController?.navigationBar.isHidden = false
        setup()
        setupKeyboardDismissal()
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc func createButtonTapped() {
        clearRegistrationErrors()

        guard let name = nameComponent.textField.text, !name.isEmpty else {
            showRegistrationError("Please enter your name."); return
        }

        guard let email = emailComponent.textField.text, !email.isEmpty, isValidEmail(email) else {
            showRegistrationError("Please enter a valid email."); return
        }

        guard let password = passwordComponent.textField.text, isValidPassword(password) else {
            showRegistrationError("Password does not meet requirements."); return
        }

        guard switchIcon.isOn else {
            showRegistrationError("Please accept the terms and privacy policy."); return
        }

        let favoriteDriver = favoriteDriverComponent.textField.text
        
        createButton.isEnabled = false
        createButton.setTitle("Creating Account...", for: .normal)

        Task {
            let newUser = User(
                name: name,
                email: email,
                password: password,
                favoriteDriver: favoriteDriver,
                currentFormula: "Formula 2",
                dateCreated: Date()
            )

            do {
                try await UserService.shared.saveUser(newUser)
                await MainActor.run { 
                    self.resetCreateButton()
                    self.navigateToMainTab() 
                }
            } catch {
                await MainActor.run {
                    self.showRegistrationError(error.localizedDescription)
                    self.resetCreateButton()
                }
            }
        }
    }
    
    private func resetCreateButton() {
        createButton.isEnabled = true
        createButton.setTitle("Create Account", for: .normal)
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let minChar = password.count >= 8
        let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasUpper = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasSpecial = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/{}~|")) != nil
        return minChar && hasNumber && hasUpper && hasSpecial
    }

    func clearRegistrationErrors() { registrationErrorLabel.isHidden = true }

    func showRegistrationError(_ msg: String) {
        registrationErrorLabel.text = msg
        registrationErrorLabel.isHidden = false
    }

    func navigateToMainTab() {
        let mainTabBar = MainTabController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = mainTabBar
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

