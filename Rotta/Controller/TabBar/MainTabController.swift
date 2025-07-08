//
//  MainTabController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

protocol FormulaFilterable {
    func updateData(for formula: FormulaType)
}

class MainTabController: UIViewController {
    var selected: String = "Formula 2"
    var currentFormula: FormulaType = .formula2

    let segmented = SegmentedControll(items: ["Calendário", "Ranking", "Infos"])

    lazy var titleSelectorButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle(selected, for: .normal)
        button.titleLabel?.font = Fonts.Title1
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .labelsPrimary
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(didTapTitleSelector), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var profileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        button.tintColor = .labelsPrimary
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()

    lazy var dropdownView: UIVisualEffectView = createDropdownView()

    var isArrowRotated = false
    let viewControllers: [UIViewController] = [CalendarVC(), TopThreeVC(), InfosVC()]
    var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        loadSelectedFormula()
        setup()
        displayViewController(at: 0)
        updateAllViewControllersForFormula()
        updateProfileButton()
    }

    @objc private func profileImageUpdated() {
        updateProfileButton()
    }

    @objc private func userDidLogout() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateProfileButton()
    }

    func displayViewController(at index: Int) {
        currentVC?.removeFromParent()
        currentVC?.view.removeFromSuperview()

        let selectedVC = viewControllers[index]
        addChild(selectedVC)
        view.addSubview(selectedVC.view)

        selectedVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedVC.view.topAnchor.constraint(equalTo: segmented.bottomAnchor, constant: 8),
            selectedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectedVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        selectedVC.didMove(toParent: self)
        currentVC = selectedVC

        view.bringSubviewToFront(titleSelectorButton)
        view.bringSubviewToFront(profileButton)
        view.bringSubviewToFront(segmented)
        view.bringSubviewToFront(dropdownView)
    }

    @objc private func didTapTitleSelector() {
        isArrowRotated.toggle()
        dropdownView.isHidden.toggle()
        view.bringSubviewToFront(dropdownView)
    }

    @objc private func didTapProfile() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }

    private func updateProfileButton() {
        if UserService.shared.getLoggedUser() != nil,
           let imageData = Database.shared.getProfileImageData(),
           let profileImage = UIImage(data: imageData) {
            let originalImage = profileImage.withRenderingMode(.alwaysOriginal)
            profileButton.setImage(originalImage, for: .normal)
            profileButton.tintColor = nil
        } else {
            let iconImage = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysTemplate)
            profileButton.setImage(iconImage, for: .normal)
            profileButton.tintColor = .labelsPrimary
        }
    }

    private func loadSelectedFormula() {
        currentFormula = Database.shared.getSelectedFormula()
        selected = currentFormula.displayName
        titleSelectorButton.setTitle(selected, for: .normal)
    }

    func updateAllViewControllersForFormula() {
        viewControllers.forEach { viewController in
            if let filterableVC = viewController as? FormulaFilterable {
                filterableVC.updateData(for: currentFormula)
            }
        }
    }
}
