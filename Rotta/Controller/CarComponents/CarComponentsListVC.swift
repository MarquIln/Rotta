//
//  CarComponentsListVC.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentsListVC: UIViewController {

    private let service = ComponentService()
    let database = Database.shared
    
    private var components: [ComponentModel] = []
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0

    private lazy var carComponentTableView: CarComponentTableView = {
        let tableView = CarComponentTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()

    private let totalCells = 10

    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        impactFeedback.prepare()
        addGradientGlossary()
        setupCustomBackButton()
        loadComponents()
        setupNotifications()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func loadComponents() {
        Task {
            components = await database.getAllComponents()
            
            await MainActor.run {
                self.carComponentTableView.configure(with: components)
            }
        }
    }

    private func setupCustomBackButton() {
        navigationItem.hidesBackButton = true

        let backButton = UIButton(type: .system)
        backButton.setImage(
            UIImage(systemName: "chevron.left.circle.fill"),
            for: .normal
        )
        backButton.tintColor = .rottaYellow
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 16
        backButton.clipsToBounds = true
        backButton.addTarget(
            self,
            action: #selector(customBackTapped),
            for: .touchUpInside
        )

        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)

        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
    }

    @objc private func customBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(componentSelected(_:)),
            name: NSNotification.Name("CarComponentSelected"),
            object: nil
        )
    }
    
    @objc private func componentSelected(_ notification: Notification) {
        guard let component = notification.object as? ComponentModel else { return }
        
        // Navegar para a tela de detalhes
        let detailsVC = CarComponentsDetailsVC()
        detailsVC.configure(with: component)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Componentes"

        view.addSubview(gradientView)
        view.addSubview(carComponentTableView)

        NSLayoutConstraint.activate([

            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            carComponentTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            carComponentTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            carComponentTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            carComponentTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
    }
}

extension CarComponentsListVC: GlossaryTableViewDelegate {
    func numberOfItems() -> Int {
        return components.count
    }

    func item(at index: Int) -> (title: String, imageName: String) {
        return (components[index].name ?? "no title", "carro")
    }

    func didSelectItem(at index: Int) {
        let carVC = CarComponentsDetailsVC()
        carVC.components = components[index]
        navigationController?.pushViewController(carVC, animated: true)
    }
}
