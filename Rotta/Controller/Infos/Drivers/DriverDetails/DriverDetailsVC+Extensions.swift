//
//  DriverDetailsVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 08/07/25.
//

import UIKit

extension DriverDetailsVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(backgroundColor)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gradientView)
        
        contentView.addSubview(NameLabel)
        contentView.addSubview(mainInfos)
        contentView.addSubview(heightAndBirth)
        contentView.addSubview(champion)
        contentView.addSubview(descriptionComponent)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            backgroundColor.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundColor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundColor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            NameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 265),
            NameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            NameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            NameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            NameLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 265),
            
            mainInfos.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 20),
            mainInfos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainInfos.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainInfos.heightAnchor.constraint(equalToConstant: 95),
            
            heightAndBirth.topAnchor.constraint(equalTo: mainInfos.bottomAnchor, constant: 20),
            heightAndBirth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heightAndBirth.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heightAndBirth.heightAnchor.constraint(equalToConstant: 46),
            
            champion.topAnchor.constraint(equalTo: heightAndBirth.bottomAnchor, constant: 20),
            champion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            champion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            champion.heightAnchor.constraint(equalToConstant: 46),
            
            descriptionComponent.topAnchor.constraint(equalTo: champion.bottomAnchor, constant: 20),
            descriptionComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionComponent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension DriverDetailsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
