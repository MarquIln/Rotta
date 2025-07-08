//
//  AllScuderiasVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 08/07/25.
//

import UIKit

extension AllScuderiasVC: ScuderiaTableViewDelegate {
    func numberOfItems() -> Int {
        scuderias.count
    }
    
    func item(at index: Int) -> (title: String, imageName: String) {
        return (scuderias[index].name, scuderias[index].logo)
    }
    
    func didSelectItem(at index: Int) {
        let detailsVC = ScuderiaDetailsVC()
            detailsVC.scuderia = scuderias[index]
          detailsVC.component.configure(with: scuderias[index])
            navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension AllScuderiasVC: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.addGradientGlossary()
        }
    }
}

extension AllScuderiasVC: ViewCodeProtocol {
    func addSubviews() {
        view.backgroundColor = .systemBackground
        title = "Scuderias"
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(gradientView)
        view.addSubview(headerView)
        view.addSubview(scuderiaTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            scuderiaTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            scuderiaTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scuderiaTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scuderiaTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        scuderiaTableView.reloadData()
    }
}
