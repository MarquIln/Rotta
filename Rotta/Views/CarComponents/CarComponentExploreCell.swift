//
//  CarComponentExploreCell.swift
//  Rotta
//
//  Created by Marcos on 26/06/25.
//

import UIKit

class CarComponentExploreCell: UIView {
    
    private var allComponents: [ComponentModel] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore outros componentes"
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var leftChevron: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.left"))
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rightChevron: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        FormulaColorManager.shared.addDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
    
    func configure(with components: [ComponentModel]) {
        self.allComponents = components
        updateContent()
    }
    
    private func updateContent() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let items = allComponents.map { component in
            createCircleItem(title: component.name ?? "Componente", imageName: component.image)
        }
        
        guard !items.isEmpty else { return }
        
        for i in stride(from: 0, to: items.count, by: 2) {
            let pageContainer = UIView()
            pageContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let pageStack = UIStackView()
            pageStack.axis = .horizontal
            pageStack.spacing = 24
            pageStack.distribution = .fillEqually
            pageStack.translatesAutoresizingMaskIntoConstraints = false
            
            let endIndex = min(i+2, items.count)
            for j in i..<endIndex {
                pageStack.addArrangedSubview(items[j])
            }
            
            pageContainer.addSubview(pageStack)
            stackView.addArrangedSubview(pageContainer)
            
            NSLayoutConstraint.activate([
                pageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                pageStack.centerXAnchor.constraint(equalTo: pageContainer.centerXAnchor),
                pageStack.centerYAnchor.constraint(equalTo: pageContainer.centerYAnchor),
                pageStack.leadingAnchor.constraint(greaterThanOrEqualTo: pageContainer.leadingAnchor, constant: 30),
                pageStack.trailingAnchor.constraint(lessThanOrEqualTo: pageContainer.trailingAnchor, constant: -30)
            ])
        }
    }
    
    private func createCircleItem(title: String, imageName: String? = nil) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 8
        
        let circle = UIView()
        circle.backgroundColor = FormulaColorManager.shared.primaryColor
        circle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        circle.layer.cornerRadius = 30
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            circle.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        container.addArrangedSubview(circle)
        container.addArrangedSubview(label)
        return container
    }
}

extension CarComponentExploreCell: ViewCodeProtocol {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(leftChevron)
        addSubview(rightChevron)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 361).isActive = true
        self.heightAnchor.constraint(equalToConstant: 156).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            leftChevron.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            leftChevron.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            rightChevron.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            rightChevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}

extension CarComponentExploreCell: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.updateContent()
        }
    }
}
