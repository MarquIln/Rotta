//
//  LoginVC.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

class LoginVC: UIViewController {
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        return headerView
    }()

    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Welcome!"
        titleLabel.font = UIFont(name: "SFProRounded-Bold", size: 34)

        return titleLabel
    }()

    lazy var headerStackView: UIStackView = {
        headerStackView = UIStackView(arrangedSubviews: [titleLabel])
        headerStackView.axis = .vertical
        headerStackView.spacing = 24
        headerStackView.translatesAutoresizingMaskIntoConstraints = false

        return headerStackView
    }()

    lazy var principalView: UIView = {
        var principalView = UIView()
        principalView.translatesAutoresizingMaskIntoConstraints = false
        principalView.backgroundColor = .backgroundPrimary
        principalView.layer.cornerRadius = 30

        return principalView
    }()

    lazy var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.textColor = .labelsPrimary
        loginLabel.text = "Login"
        loginLabel.font = UIFont(name: "SFProRounded-Bold", size: 28)
        loginLabel.textAlignment = .center
        return loginLabel
    }()

    lazy var emailComponent: NamedTextField = {
        var view = NamedTextField()
        view.name = "Email"
        view.placeholder = "abc@abc.com"
        view.delegate = self

        return view
    }()

    lazy var passwordComponent: NamedTextField = {
        var view = NamedTextField()
        view.name = "Password"
        view.placeholder = "********"
        view.delegate = self
        view.textField.isSecureTextEntry = true

        return view
    }()

    lazy var textFieldsStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            emailComponent, passwordComponent,
        ])

        stack.axis = .vertical
        stack.spacing = 20

        return stack
    }()

    lazy var mainStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            loginLabel, textFieldsStackView,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()

    lazy var forgotPassword: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .formulaRace
        label.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        label.text = "Forgot password?"
        label.textAlignment = .right
        return label
    }()

    lazy var emailAndPasswordErrorLabel: UILabel = {
        var label = UILabel()
        label.text =
            "The email and password you entered did not match our record. Please try again."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 2
        return label
    }()

    lazy var createAccountButton: UIButton = {
        var button = UIButton()
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(.formulaRace, for: .normal)
        button.titleLabel?.font = UIFont(
            name: "SFProRounded-Semibold",
            size: 16
        )
        button.addTarget(
            self,
            action: #selector(createAccountButtonTapped),
            for: .touchUpInside
        )
        button.backgroundColor = .backgroundSecondary
        button.layer.cornerRadius = 12

        return button
    }()

    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .formulaRace
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(
            name: "SFProRounded-Semibold",
            size: 16
        )

        return button
    }()

    lazy var actionButtonsStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            loginButton, createAccountButton,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill

        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
        navigationController?.navigationBar.isHidden = true

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapGesture)
        setup()
        setupSwipeGesture()
        loginButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearLoginErrors()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func togglePasswordVisibility(_ button: UIButton) {
        passwordComponent.textField.isSecureTextEntry.toggle()

        let imageName =
            passwordComponent.textField.isSecureTextEntry ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc func didTapLoginButton() {
        guard let email = emailComponent.textField.text, !email.isEmpty,
              let password = passwordComponent.textField.text, !password.isEmpty else {
            emailAndPasswordErrorLabel.text = "Email and password cannot be empty."
            emailAndPasswordErrorLabel.isHidden = false
            return
        }

        Task {
            do {
                if let _ = try await UserService.shared.loginUser(email: email, password: password) {
                    navigateToMainTab()
                } else {
                    emailAndPasswordErrorLabel.text = "The email and password you entered did not match our records."
                    emailAndPasswordErrorLabel.isHidden = false
                }
            } catch {
                if let nsError = error as NSError? {
                    switch nsError.code {
                    case 1001:
                        emailAndPasswordErrorLabel.text = "iCloud is not available. Please sign in to iCloud in Settings."
                    case 1003:
                        emailAndPasswordErrorLabel.text = "Unable to verify credentials. Please check your internet connection."
                    default:
                        emailAndPasswordErrorLabel.text = "An error occurred during login. Please try again."
                    }
                } else {
                    emailAndPasswordErrorLabel.text = "An error occurred during login. Please try again."
                }
                emailAndPasswordErrorLabel.isHidden = false
            }
        }
    }

    @objc func createAccountButtonTapped() {
        let nextVC = RegisterVC()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    private func navigateToMainTab() {
        let mainTabBarController = MainTabController()
        let navController = UINavigationController(rootViewController: mainTabBarController)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
