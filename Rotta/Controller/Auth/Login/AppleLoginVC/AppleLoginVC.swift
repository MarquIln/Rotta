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
            nameComponent, emailComponent, formulaSelectionView, driverSelectionView
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
                let _ = try await UserService.shared.registerAppleUser(
                    credential: appleCredential,
                    customName: name,
                    customEmail: email,
                    favoriteDriver: selectedDriver?.name,
                    preferredFormula: selectedFormula
                )
                
                DispatchQueue.main.async {
                    self.navigateToMainTab()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(message: "Failed to complete setup. Please try again.")
                }
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
