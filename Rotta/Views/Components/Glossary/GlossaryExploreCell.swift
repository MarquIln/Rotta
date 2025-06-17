////
////  GlossaryExploreCell.swift
////  Rotta
////
////  Created by sofia leitao on 16/06/25.
////
//import UIKit
//
//class GlossaryItemViewCell: UICollectionViewCell {
//    static let identifier = "GlossaryItemViewCell"
//    
//    let imageView: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentMode = .scaleAspectFill
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 40
//        view.backgroundColor = .darkGray
//        return view
//    }()
//    
//    let label: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Palavra"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .white
//        label.textAlignment = .center
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        contentView.addSubview(imageView)
//        contentView.addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 80),
//            imageView.heightAnchor.constraint(equalToConstant: 80),
//            
//            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
