//
//  InfosViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class InfosVC: UIViewController {
    var currentFormula: FormulaType = Database.shared.getSelectedFormula()
    
    let cardsData: [(title: String, subtitle: String, image: UIImage)] = [
        (
            title: "Glossário",
            subtitle: "Entenda os principais termos utilizados na Fórmula 2",
            image: .glossaryCategoryInfos,
        ),
        (
            title: "Scuderias",
            subtitle: "Conheça as scuderias da Fórmula 2",
            image: .componentsCategoryInfos
        ),
        (
            title: "Pilotos",
            subtitle: "Conheça os pilotos da Fórmula 2",
            image: .componentsCategoryInfos
        ),
        (
            title: "Peças",
            subtitle: "Conheça as peças que compõem os carros da Fórmula 2",
            image: .componentsCategoryInfos
        )
    ]
    
    lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardInfosCell.self, forCellWithReuseIdentifier: CardInfosCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        setup()
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

    @objc func cardInfoTapped(_ sender: UIButton) {
        let index = sender.tag
        guard index < cardsData.count else { return }
        
        let selectedCard = cardsData[index]
        
        switch selectedCard.title {
        case "Glossário":
            let vc = GlossaryTableViewController()
            if let filterableVC = vc as? FormulaFilterable {
                filterableVC.updateData(for: currentFormula)
            }
            navigationController?.pushViewController(vc, animated: true)

        case "Scuderias":
            let vc = AllScuderiasVC()
            vc.updateData(for: currentFormula)
            navigationController?.pushViewController(vc, animated: true)

        case "Pilotos":
            let vc = AllDriversVC()
            vc.updateData(for: currentFormula)
            navigationController?.pushViewController(vc, animated: true)
            
        case "Peças":
            let vc = CarComponentsListVC()
            if let filterableVC = vc as? FormulaFilterable {
                filterableVC.updateData(for: currentFormula)
            }
            navigationController?.pushViewController(vc, animated: true)

        default:
            print("Card não reconhecido")
        }
    }

}
