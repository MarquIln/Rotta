//
//  MainTabController+Dropdown.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//

import UIKit

extension MainTabController {

    func createDropdownView() -> UIVisualEffectView {
        let blurView = createBlurContainer()
        let stackView = createDropdownStack()

        blurView.contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -16),
        ])

        return blurView
    }

    private func createDropdownStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false

        let formulas = FormulaType.allCases.map { $0.displayName }

        for (index, option) in formulas.enumerated() {
            var config = UIButton.Configuration.plain()
            config.title = option
            config.baseForegroundColor = .labelsPrimary
            config.titleAlignment = .leading

            if option == selected {
                config.image = UIImage(systemName: "checkmark")
                config.imagePlacement = .leading
                config.imagePadding = 8
                config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            } else {
                config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 31, bottom: 0, trailing: 0)
            }

            let button = UIButton(configuration: config)
            button.contentHorizontalAlignment = .leading
            button.semanticContentAttribute = .forceLeftToRight
            button.addTarget(self, action: #selector(didSelectDropdownOption(_:)), for: .touchUpInside)

            stack.addArrangedSubview(button)

            if index < formulas.count - 1 {
                let separator = UIView()
                separator.backgroundColor = .separator
                separator.translatesAutoresizingMaskIntoConstraints = false
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                stack.addArrangedSubview(separator)
            }
        }

        return stack
    }

    private func createBlurContainer() -> UIVisualEffectView {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isHidden = true
        return blurView
    }

    @objc func didSelectDropdownOption(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        titleSelectorButton.setTitle("\(title) ", for: .normal)
        dropdownView.isHidden = true
        selected = title

        if let newFormula = FormulaType(rawValue: title) {
            currentFormula = newFormula
            Database.shared.saveSelectedFormula(newFormula)
            FormulaColorManager.shared.notifyFormulaChange(newFormula)
            updateAllViewControllersForFormula()
        }

        resetArrow()

        dropdownView.contentView.subviews.forEach { $0.removeFromSuperview() }
        let newStack = createDropdownStack()
        dropdownView.contentView.addSubview(newStack)

        NSLayoutConstraint.activate([
            newStack.topAnchor.constraint(equalTo: dropdownView.contentView.topAnchor, constant: 12),
            newStack.bottomAnchor.constraint(equalTo: dropdownView.contentView.bottomAnchor, constant: -12),
            newStack.leadingAnchor.constraint(equalTo: dropdownView.contentView.leadingAnchor, constant: 16),
            newStack.trailingAnchor.constraint(equalTo: dropdownView.contentView.trailingAnchor, constant: -16),
        ])
    }

    func resetArrow() {
        UIView.animate(withDuration: 0.2, animations: {
            self.titleSelectorButton.imageView?.alpha = 0
        }) { _ in
            self.titleSelectorButton.imageView?.transform = .identity
            UIView.animate(withDuration: 0.2) {
                self.titleSelectorButton.imageView?.alpha = 1
            }
        }
        isArrowRotated = false
    }
}
