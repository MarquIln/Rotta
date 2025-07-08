//
//  Untitled.swift
//  Rotta
//
//  Created by sofia leitao on 16/06/25.
//

import UIKit

class GlossaryHeaderView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var imageViews: [UIImageView] = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return [imageView]
    }()
    
    lazy var glossaryStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private var names = [
        "drs_image",
        "ers_image",
        "polePosition_image",
        "dnf_image",
        "dns_image",
        "dsq_image",
        "safetyCar_image",
        "virtualSafetyCar_image",
        "pitStop_image",
        "undercut_image",
        "overcut_image",
        "slipstream_image",
        "dirtyAir_image",
        "apex_image",
        "chicane_image",
        "kerb_image",
        "marshals_image",
        "parcFerme_image",
        "formationLap_image",
        "fastestLap_image"
    ];
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        setupImageViews()
    }
    
    private func setupImageViews() {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 12
        verticalStack.alignment = .center
        verticalStack.distribution = .equalSpacing
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            verticalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            verticalStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
        
        let firstRowLogos = Array(names.prefix(5))
        let secondRowLogos = Array(names.suffix(5))
        
        let firstRowStack = createLogoRow(with: firstRowLogos)
        verticalStack.addArrangedSubview(firstRowStack)
        
        let secondRowStack = createLogoRow(with: secondRowLogos)
        verticalStack.addArrangedSubview(secondRowStack)
        
    }
    
    private func createLogoRow(with logos: [String]) -> UIStackView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 12
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        for logoName in logos {
            let logoView = UIImageView()
            logoView.contentMode = .scaleAspectFill
            logoView.image = UIImage(named: logoName)
            logoView.clipsToBounds = true
            
            logoView.widthAnchor.constraint(equalToConstant: 52).isActive = true
            logoView.heightAnchor.constraint(equalToConstant: 52).isActive = true
            logoView.layer.cornerRadius = 52 / 2
            
            horizontalStack.addArrangedSubview(logoView)
            imageViews.append(logoView)
        }
        
        return horizontalStack
    }
}


