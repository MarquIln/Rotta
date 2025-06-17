//
//  MarcosVC.swift
//  Rotta
//
//  Created by Marcos on 17/06/25.
//

import UIKit

class OnBoardingVC: UIViewController {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar no App", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupButtonTarget()
    }
    
    private func setupButtonTarget() {
        button.addTarget(self, action: #selector(handleGoNext), for: .touchUpInside)
    }
    
    @objc func handleGoNext() {
        print("🔥 handleGoNext chamado!")
        
        let nextVC = MainTabController()
        
        // Usar navegação normal do NavigationController configurado no SceneDelegate
        if let navController = navigationController {
            print("✅ NavigationController encontrado - fazendo push")
            navController.pushViewController(nextVC, animated: true)
        } else {
            print("❌ NavigationController não encontrado")
        }
    }
}

extension OnBoardingVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
