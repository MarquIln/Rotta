//
//  DriverPodium.swift
//  Rotta
//
//  Created by Marcos on 21/06/25.
//

import UIKit
import SkeletonView

class DriverPodium: UIView {
    private var needsGradientUpdate = false
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilotos"
        label.font = Fonts.Title2
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right.circle.fill"), for: .normal)
        button.tintColor = .rottaYellow
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
    
    let secondPlaceView = DriverView()
    let firstPlaceView = DriverView()
    let thirdPlaceView = DriverView()
    
    private lazy var driverStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secondPlaceView, firstPlaceView, thirdPlaceView])
        stack.distribution = .fillEqually
        stack.alignment = .bottom
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLabel, seeAllButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true

        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerStack, driverStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 32
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        gradient.layer.cornerRadius = 32
        return gradient
    }()
    
    @objc func addGradient() {
        DispatchQueue.main.async {
            self.gradientView.addGradientRankingView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSkeleton()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupSkeleton()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
    
    private func setupSkeleton() {
        // Configurar view principal
        isSkeletonable = true
        
        // Configurar stacks
        containerStack.isSkeletonable = true
        headerStack.isSkeletonable = true
        driverStack.isSkeletonable = true
        
        // Configurar componentes do header
        headerLabel.isSkeletonable = true
        seeAllButton.isSkeletonable = true
        
        // Configurar views dos pilotos
        firstPlaceView.isSkeletonable = true
        secondPlaceView.isSkeletonable = true
        thirdPlaceView.isSkeletonable = true
        
        // Configurar gradiente view
        gradientView.isSkeletonable = true
        
        // Configurar propriedades específicas do skeleton
        headerLabel.linesCornerRadius = 8
        seeAllButton.skeletonCornerRadius = 12
        firstPlaceView.skeletonCornerRadius = 12
        secondPlaceView.skeletonCornerRadius = 12
        thirdPlaceView.skeletonCornerRadius = 12
    }
    
    func showSkeleton() {
        showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
    }
    
    func showLoadingSkeleton() {
        showAnimatedGradientSkeleton()
    }
    
    func hideLoadingSkeleton() {
        hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Só aplica o gradiente se o containerStack tem um frame válido
        guard containerStack.bounds.width > 0 && containerStack.bounds.height > 0 else { return }
        
        let hasGradientLayer = containerStack.layer.sublayers?.contains { $0 is CAGradientLayer } ?? false
        if needsGradientUpdate || !hasGradientLayer {
            containerStack.addGradientRankingView()
            needsGradientUpdate = false
        }
    }
    
    func update(with drivers: [DriverModel]) {
        let sorted = drivers.sorted { $0.points > $1.points }
        if sorted.count > 0 { firstPlaceView.configure(with: sorted[0], rank: 1) }
        if sorted.count > 1 { secondPlaceView.configure(with: sorted[1], rank: 2) }
        if sorted.count > 2 { thirdPlaceView.configure(with: sorted[2], rank: 3) }
    }
}

extension DriverPodium: ViewCodeProtocol {
    func addSubviews() {
        addSubview(containerStack)
        containerStack.addSubview(gradientView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension DriverPodium: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        needsGradientUpdate = true
        DispatchQueue.main.async {
            self.addGradient()
            self.setNeedsLayout()
        }
    }
}
