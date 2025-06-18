//
//  TopThreeDriversView.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit

class TopThreeDriversView: UIView {
    private var drivers: [DriverModel] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.text = "Drivers"
        label.textAlignment = .center
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.tintColor = .white
        return button
    }()

    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, seeAllButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(DriversCell.self, forCellWithReuseIdentifier: DriversCell.reuseIdentifier)

        return collection
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, collectionView])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 32
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(with drivers: [DriverModel]) {
        self.drivers = Array(drivers.prefix(3))
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientCardInfos()
    }
}

extension TopThreeDriversView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

extension TopThreeDriversView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DriversCell.reuseIdentifier, for: indexPath) as! DriversCell
        let driver = drivers[indexPath.item]
        cell.configure(with: driver, rank: indexPath.item + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.width / 3 - 16
        return CGSize(width: width, height: 150)
    }
}
