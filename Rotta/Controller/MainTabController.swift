//
//  Untitled.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//
import UIKit

class MainTabController: UIViewController {
    let segmented = SegmentedControll(items: ["Calendário", "Ranking", "Infos"])
    
    lazy var titleSelectorButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Fórmula 2 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(didTapTitleSelector), for: .touchUpInside)
        
        return button
    }()
    
    lazy var dropdownView: UIStackView = {
        let options = ["Fórmula 2", "Fórmula 3", "F1 Academy"]
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        stack.backgroundColor = UIColor.systemGray6
        stack.layer.cornerRadius = 8
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.systemGray4.cgColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isHidden = true

        for option in options {
            let button = UIButton(type: .system)
            button.setTitle("GP de \(option)", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.contentHorizontalAlignment = .center
            button.addTarget(self, action: #selector(didSelectDropdownOption(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }

        return stack
    }()
    
    var isArrowRotated = false

    let viewControllers: [UIViewController] = [
        CalendarViewController(),
        RankingViewController(),
        InfosViewController()
    ]

    var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        setup()
        displayViewController(at: 0)
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
    }

    @objc private func didTapTitleSelector() {
        UIView.animate(withDuration: 0.3) {
            self.titleSelectorButton.imageView?.transform = self.isArrowRotated ? .identity : CGAffineTransform(rotationAngle: .pi / 2)
        }
        isArrowRotated.toggle()

        let alert = UIAlertController(title: "Selecionar GP", message: nil, preferredStyle: .actionSheet)
        let options = ["Silverstone", "Monza", "Interlagos"]
        options.forEach { gp in
            alert.addAction(UIAlertAction(title: "GP de \(gp)", style: .default) { _ in
                self.titleSelectorButton.setTitle("GP de \(gp) ", for: .normal)
                self.resetArrow()
            })
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            self.resetArrow()
        })

        present(alert, animated: true)
    }

    private func resetArrow() {
        UIView.animate(withDuration: 0.3) {
            self.titleSelectorButton.imageView?.transform = .identity
        }
        isArrowRotated = false
    }
    
    @objc private func didSelectDropdownOption(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        titleSelectorButton.setTitle(title + " ", for: .normal)
        dropdownView.isHidden = true
        resetArrow()
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
        view.addSubview(dropdownView)
        view.addSubview(segmented)
    }

    func setupConstraints() {
        titleSelectorButton.translatesAutoresizingMaskIntoConstraints = false
        segmented.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleSelectorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleSelectorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dropdownView.topAnchor.constraint(equalTo: titleSelectorButton.bottomAnchor, constant: 4),
            dropdownView.centerXAnchor.constraint(equalTo: titleSelectorButton.centerXAnchor),
            dropdownView.widthAnchor.constraint(equalToConstant: 160),

            segmented.topAnchor.constraint(equalTo: titleSelectorButton.bottomAnchor, constant: 8),
            segmented.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmented.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmented.heightAnchor.constraint(equalToConstant: 32)
        ])

        segmented.didSelectSegment = { [weak self] index in
            self?.displayViewController(at: index)
        }
    }
}
