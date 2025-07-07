//
//  CarComponentsListVC.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit

class CarComponentsListVC: UIViewController {
    let database = Database.shared
    
    private var components: [ComponentModel] = []
    
    private lazy var headerView: CarComponentHeader = {
        let headerView = CarComponentHeader()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        return headerView
    }()

    private lazy var carComponentTableView: CarComponentTableView = {
        let tableView = CarComponentTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableView.delegate = self
        tableView.tableView.dataSource = self
        return tableView
    }()

    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()

    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addGradientGlossary()
        setupCustomBackButton()
        
        loadComponents()
        navigationController?.isNavigationBarHidden = false
        title = "Componentes"
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
}

extension CarComponentsListVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(gradientView)
        view.addSubview(carComponentTableView)
        view.addSubview(headerView)
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            headerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 118
            ),
            headerView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            headerView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),

            carComponentTableView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
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

extension CarComponentsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarComponentCell.reuseIdentifier, for: indexPath) as? CarComponentCell else {
            return UITableViewCell()
        }
        
        let component = components[indexPath.row]
        cell.config(with: component, cellIndex: indexPath.row)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = components[indexPath.row]
        let detailsVC = CarComponentsDetailsVC()
        detailsVC.carComponent = component
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
