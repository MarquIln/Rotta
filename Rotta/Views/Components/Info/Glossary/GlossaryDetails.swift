//
//  GlossaryWordDescription.swift
//  Rotta
//
//  Created by sofia leitao on 12/06/25.
//

import UIKit

class GlossaryDetails: UIView {
    
    var term: GlossaryModel? = nil {
        didSet {
            configure(with: term!)
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = term?.title
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title3
        return label
    }()
    
    lazy var descripText: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = term?.details
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
        label.text = term?.subtitle
        label.textColor = .white
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descrip2Text: UILabel = {
        var label = UILabel()
        label.text = term?.details
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
    

    lazy var exploreContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var exploreCell: GlossaryExploreCell = {
            let cell = GlossaryExploreCell()
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, descripContainer, descrip2Container, exploreContainer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    init(frame: CGRect, term: GlossaryModel) {
        super.init(frame: frame)
        self.term = term
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

}

extension GlossaryDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
        descripContainer.addSubview(descripText)
        descrip2Container.addSubview(stackTexts)
        exploreContainer.addSubview(exploreCell)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
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
            
            exploreCell.topAnchor.constraint(equalTo: exploreContainer.topAnchor),
            exploreCell.bottomAnchor.constraint(equalTo: exploreContainer.bottomAnchor),
            exploreCell.leadingAnchor.constraint(equalTo: exploreContainer.leadingAnchor),
            exploreCell.trailingAnchor.constraint(equalTo: exploreContainer.trailingAnchor),
                       
           exploreContainer.heightAnchor.constraint(equalToConstant: 156)
    
        ])
    }
}

extension GlossaryDetails {
    
    func configure(with model: GlossaryModel) {
        label.text = model.title
        descripText.text = model.details
        descrip2Title.text = model.subtitle
        descrip2Text.text = model.details
        
    }
}
    
