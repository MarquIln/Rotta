//
//  GlossaryViewController.swift
//  Rotta
//
//  Created by sofia leitao on 16/06/25.
//

import UIKit

class GlossaryDetailsViewController: UIViewController {

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
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()
    
    lazy var imageBackground: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .drs2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addGradientGlossary()
    }
}

extension GlossaryDetailsViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(gradientView)
        
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
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            component.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 212),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

    }
}

