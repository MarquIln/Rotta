//
//  TestViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 11/06/25.
//

import UIKit

class TestController: UIViewController {

    lazy var component: GlossaryWordDescription = {
        var component =  GlossaryWordDescription()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var imageBackground: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .drs2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .systemBackground
    }
}

extension TestController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(component)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: 362),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            component.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 212),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
