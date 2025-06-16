//
//  InfosViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class InfosViewController: UIViewController {
    private let cardsData: [(title: String, subtitle: String, image: UIImage)] = [
        (
            title: "Glossário",
            subtitle: "Entenda os principais termos utilizados na Fórmula 2",
            image: .glossaryCategoryInfos
        ),
        (
            title: "Peças",
            subtitle: "Conheça as principais peças dos carros da Fórmula 2",
            image: .componentsCategoryInfos
        ),
        (
            title: "Peças",
            subtitle: "Conheça as principais peças dos carros da Fórmula 2",
            image: .componentsCategoryInfos
        )
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize = .zero

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardInfosCell.self, forCellWithReuseIdentifier: CardInfosCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        setup()
    }

//    @objc private func cardInfoTapped(_ sender: CardInfosButton) {
//        print("CardInfosButton foi tocado!")
//    }
    
    @objc private func cardInfoTapped(_ sender: UIButton) {
        let index = sender.tag
        let item = cardsData[index]
//        let modal = GlossaryTableViewController()
//        modal.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//        present(modal, animated: true , completion: nil)
    }

}

// MARK: - ViewCodeProtocol

extension InfosViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension InfosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardInfosCell.identifier, for: indexPath
        ) as? CardInfosCell else {
            return UICollectionViewCell()
        }

        let item = cardsData[indexPath.item]
        cell.configure(
            with: item.title,
            subtitle: item.subtitle,
            image: item.image,
            target: self,
            action: #selector(cardInfoTapped(_:)),
        )
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardInfosCell else { return }
        let button = cell.cardButtonPublic
        cardInfoTapped(button)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InfosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = collectionView.bounds.width * 0.93
        return CGSize(width: width, height: height)
    }
}
