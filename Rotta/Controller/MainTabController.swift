//
//  Untitled.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

enum FormulaType: String, CaseIterable {
    case f1Academy = "F1 Academy"
    case formula2 = "Formula 2"
    case formula3 = "Formula 3"
    
    var displayName: String {
        return self.rawValue
    }
}

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
    
    lazy var dropdownView: UIVisualEffectView = {
        let blurView = createBlurContainer()
        let stackView = createDropdownStack()

        blurView.contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -16)
        ])

        return blurView
    }()
    
    private func createDropdownStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false

        let formulas = FormulaType.allCases.map { $0.displayName }
        for (index, option) in formulas.enumerated() { //.enumerated() transforma o array em tupla com indice :)
            var buttonConfig = UIButton.Configuration.plain()
            buttonConfig.title = option
            buttonConfig.baseForegroundColor = .labelsPrimary
            buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
            buttonConfig.titleAlignment = .leading
            
            if option == selected {
                // item selecionado: mostra check e padding menor
                buttonConfig.image = UIImage(systemName: "checkmark")
                buttonConfig.imagePlacement = .leading
                buttonConfig.imagePadding = 8
                buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            } else {
                // itens sem check: aumenta só o leading
                buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 31, bottom: 0, trailing: 0)
            }
            
            
            let button = UIButton(configuration: buttonConfig)
            button.contentHorizontalAlignment = .leading
            button.semanticContentAttribute = .forceLeftToRight
            button.addTarget(self, action: #selector(didSelectDropdownOption(_:)), for: .touchUpInside)
            
//            //check mark
//            if option == selected {
//                button.setImage(UIImage(systemName: "checkmark"), for: .normal)
//                button.semanticContentAttribute = .forceLeftToRight
//            }
            
            stack.isUserInteractionEnabled = true

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
    
    var isArrowRotated = false

    let viewControllers: [UIViewController] = [
        CalendarViewController(),
        TopThreeVC(),
        InfosViewController(),
       
      
    ]

    var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
    
        loadSelectedFormula()
        
        setup()
        displayViewController(at: 0)
        
        updateAllViewControllersForFormula()
    }
    
    private func loadSelectedFormula() {
        currentFormula = UserPreferencesManager.shared.getSelectedFormula()
        selected = currentFormula.displayName
        titleSelectorButton.setTitle(selected, for: .normal)
    }

    private func displayViewController(at index: Int) {
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
            selectedVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        selectedVC.didMove(toParent: self)
        currentVC = selectedVC

        view.bringSubviewToFront(titleSelectorButton)
        view.bringSubviewToFront(segmented)
        view.bringSubviewToFront(dropdownView)
    }


    @objc private func didTapTitleSelector() {
        isArrowRotated.toggle()
        dropdownView.isHidden.toggle()
        view.bringSubviewToFront(dropdownView)
    }


    private func resetArrow() {
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
    
    private func createBlurContainer() -> UIVisualEffectView {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isHidden = true
        return blurView
    }
    
    private func checkMark() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "checkmark.circle.fill")
        config.baseForegroundColor = .labelsPrimary
        config.contentInsets = .zero
        config.imagePlacement = .leading

        let button = UIButton(configuration: config)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func didSelectDropdownOption(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        titleSelectorButton.setTitle("\(title) ", for: .normal)
        dropdownView.isHidden = true
        selected = title
        
        if let newFormula = FormulaType(rawValue: title) {
            currentFormula = newFormula
            UserPreferencesManager.shared.saveSelectedFormula(newFormula)
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
            newStack.trailingAnchor.constraint(equalTo: dropdownView.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func updateAllViewControllersForFormula() {
        viewControllers.forEach { viewController in
            if let filterableVC = viewController as? FormulaFilterable {
                filterableVC.updateData(for: currentFormula)
            }
        }
    }
}

// MARK: - ViewCodeProtocol

extension MainTabController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(titleSelectorButton)
        view.addSubview(segmented)
        view.addSubview(dropdownView)
    }

    func setupConstraints() {
        segmented.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleSelectorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            titleSelectorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dropdownView.topAnchor.constraint(equalTo: titleSelectorButton.bottomAnchor, constant: 4),
            dropdownView.centerXAnchor.constraint(equalTo: titleSelectorButton.centerXAnchor),
            dropdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            segmented.topAnchor.constraint(equalTo: titleSelectorButton.bottomAnchor, constant: 20),
            segmented.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmented.heightAnchor.constraint(equalToConstant: 32)
        ])

        segmented.didSelectSegment = { [weak self] index in
            self?.displayViewController(at: index)
        }
    }
}

