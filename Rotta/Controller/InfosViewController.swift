//
//  InfosViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//
import UIKit

class InfosViewController: UIViewController {

    lazy var cardInfo: CardInfosButton = {
        let image = CardInfosButton(
            title: "Glossário",
            subtitle: "Entenda os principais termos utilizados na Fórmula 2"
        )
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        setup()

        cardInfo.addTarget(
            self,
            action: #selector(cardInfoTapped(_:)),
            for: .touchUpInside
        )

    }

    @objc private func cardInfoTapped(_ sender: CardInfosButton) {
        print("CardInfosButton foi tocado!")
    }

}
extension InfosViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(cardInfo)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardInfo.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            cardInfo.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            cardInfo.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            cardInfo.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
        ])
    }
}
