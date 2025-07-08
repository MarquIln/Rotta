//
//  InfosVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 08/07/25.
//

import UIKit

extension InfosVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(cardCollectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        cardCollectionView.reloadData()
    }
}

extension InfosVC: UICollectionViewDelegate, UICollectionViewDataSource {
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
            tag: indexPath.item,
            target: self,
            action: #selector(cardInfoTapped(_:))
        )
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardInfosCell else { return }
        let button = cell.cardButtonPublic
        cardInfoTapped(button)
    }
}

extension InfosVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = collectionView.bounds.width * 0.93
        return CGSize(width: width, height: height)
    }
}

extension InfosVC: FormulaFilterable {
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        updateCardsData(for: formula)
    }
    
    private func updateCardsData(for formula: FormulaType) {
        print("Atualizando dados para: \(formula.displayName)")
    }
}
