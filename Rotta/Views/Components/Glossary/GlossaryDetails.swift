//
//  GlossaryWordDescription.swift
//  Rotta
//
//  Created by sofia leitao on 12/06/25.
//

import UIKit

class GlossaryDetails: UIView {// UICollectionViewDataSource 
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DRS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var descripText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
Significa Sistema de Redução de Arrasto (Drag Reduction System em inglês) e é um sistema que reduz o arrasto aerodinâmico dos carros, permitindo-lhes alcançar velocidades máximas mais elevadas e, consequentemente, facilitando as ultrapassagens.
"""
        label.textColor = .white
        label.font = Fonts.BodyRegular
        label.textAlignment = .center
        
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descripContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()

    lazy var descrip2Title: UILabel = {
        var label = UILabel()
        label.text = "Zona de DRS"
        label.textColor = .white
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descrip2Text: UILabel = {
        var label = UILabel()
        label.text = """
O DRS pode ser usado pelos pilotos em zonas designadas durante os treinos livres, classificação e corridas. A pista tem zonas específicas onde o DRS pode ser ativado, com o carro perseguidor precisando estar a menos de um segundo do carro da frente para que a aba traseira se abra. O DRS é desativado ao final das zonas designadas e quando o piloto utiliza os freios
"""
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.BodyRegular
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackTexts: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descrip2Title, descrip2Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        return stack
    }()
    
    
    lazy var descrip2Container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()
    
//    lazy var exploreLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Explore nosso glossário"
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        label.textAlignment = .center
//        return label
//    }()
//
//    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 100, height: 120)
//        layout.minimumLineSpacing = 16
//        return layout
//    }()
//
//    lazy var exploreCarousel: UICollectionView = {
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.backgroundColor = .clear
//        collection.showsHorizontalScrollIndicator = false
//        collection.register(GlossaryItemViewCell.self, forCellWithReuseIdentifier: GlossaryItemViewCell.identifier)
//        collection.dataSource = self
//        return collection
//    }()
//    

    lazy var exploreContainer: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32

        return view
    }()

    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, descripContainer, descrip2Container, exploreContainer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//           return 10
//       }
//
//       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlossaryItemViewCell.identifier, for: indexPath) as? GlossaryItemViewCell else {
//               return UICollectionViewCell()
//           }
//
//           cell.imageView.tintColor = .blue
//           cell.label.text = "Palavra"
//           return cell
//       }
}

extension GlossaryDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
        descripContainer.addSubview(descripText)
        descrip2Container.addSubview(stackTexts)
//        addSubview(exploreLabel)
//        addSubview(exploreCarousel)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descripText.topAnchor.constraint(equalTo: descripContainer.topAnchor, constant: 12),
            descripText.bottomAnchor.constraint(equalTo: descripContainer.bottomAnchor, constant: -12),
            descripText.leadingAnchor.constraint(equalTo: descripContainer.leadingAnchor, constant: 16),
            descripText.trailingAnchor.constraint(equalTo: descripContainer.trailingAnchor, constant: -16),
            
            descrip2Title.topAnchor.constraint(equalTo: descrip2Container.topAnchor, constant: 12),
        
            descrip2Text.topAnchor.constraint(equalTo: descrip2Title.bottomAnchor, constant: 8),
            descrip2Text.bottomAnchor.constraint(equalTo: descrip2Container.bottomAnchor, constant: -12),
            descrip2Text.leadingAnchor.constraint(equalTo: descrip2Container.leadingAnchor, constant: 16),
            descrip2Text.trailingAnchor.constraint(equalTo: descrip2Container.trailingAnchor, constant: -16),
            
//           exploreLabel.topAnchor.constraint(equalTo: exploreContainer.bottomAnchor, constant: 32),
//            exploreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//
//               exploreCarousel.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 16),
//            exploreCarousel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            exploreCarousel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            exploreCarousel.heightAnchor.constraint(equalToConstant: 120),
    
        ])
    }
}
    
