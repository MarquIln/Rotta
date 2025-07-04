//
//  CarComponentDetails.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit
import AudioToolbox

class CarComponentDetails: UIView {
    
    var component: ComponentModel? {
        didSet {
            configure(with: component!)
        }
    }
    
    private var vibrateTimer: Timer?
    private var impactFeedback: UIImpactFeedbackGenerator?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var vibrateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rottaYellow
        button.layer.cornerRadius = 24
        
        button.setTitle("Sinta a vibração do motor", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.BodyRegular
        
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        
        // Adicionar os eventos de touch para vibração contínua
        button.addTarget(self, action: #selector(startVibrating), for: .touchDown)
        button.addTarget(self, action: #selector(stopVibrating), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = component?.name
        label.textColor = .white
        label.textAlignment = .center
        label.font = Fonts.Title1
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = component?.details
        label.textColor = .white
        label.font = Fonts.BodyRegular
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fillsTextBox
        view.layer.cornerRadius = 32
        return view
    }()
    
    lazy var propertiesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Caracteristicas"
        label.textColor = .white
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        return label
    }()
    
    lazy var propertiesText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = component?.property
        label.textColor = .white
        label.font = Fonts.BodyRegular
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var propertiesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [propertiesTitle, propertiesText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var propertiesContainer: UIView = {
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
    
    lazy var exploreCell: CarComponentExploreCell = {
        let cell = CarComponentExploreCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailsContainer, propertiesContainer, exploreContainer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    init(frame: CGRect, component: ComponentModel) {
        super.init(frame: frame)
        self.component = component
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    deinit {
        vibrateTimer?.invalidate()
        vibrateTimer = nil
    }
    
    @objc private func startVibrating() {
        impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback?.prepare()
        
        impactFeedback?.impactOccurred()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

        startContinuousAnimations()
        
        vibrateTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            self.impactFeedback?.impactOccurred()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    @objc private func stopVibrating() {
        vibrateTimer?.invalidate()
        vibrateTimer = nil
        
        impactFeedback = nil
        
        stopContinuousAnimations()
    }
    
    private func startContinuousAnimations() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-3.0, 3.0, -2.0, 2.0, -1.0, 1.0, 0.0]
        shakeAnimation.repeatCount = .infinity
        
        let imageShakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        imageShakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        imageShakeAnimation.duration = 0.3
        imageShakeAnimation.values = [-2.0, 2.0, -1.5, 1.5, -1.0, 1.0, 0.0]
        imageShakeAnimation.repeatCount = .infinity
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.15
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 0.98
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        
        vibrateButton.layer.add(shakeAnimation, forKey: "continuousShake")
        imageView.layer.add(imageShakeAnimation, forKey: "continuousImageShake")
        vibrateButton.layer.add(pulseAnimation, forKey: "continuousPulse")
        
        UIView.animate(withDuration: 0.1) {
            self.vibrateButton.backgroundColor = .rottaYellow.withAlphaComponent(0.8)
        }
    }
    
    private func stopContinuousAnimations() {
        vibrateButton.layer.removeAnimation(forKey: "continuousShake")
        imageView.layer.removeAnimation(forKey: "continuousImageShake")
        vibrateButton.layer.removeAnimation(forKey: "continuousPulse")
        
        UIView.animate(withDuration: 0.1) {
            self.vibrateButton.backgroundColor = .rottaYellow
        }
    }
    
    func configure(with component: ComponentModel) {
        imageView.image = UIImage(named: component.image ?? "")
        titleLabel.text = component.name
        detailsLabel.text = component.details
        propertiesText.text = component.property
    }
}

extension CarComponentDetails: ViewCodeProtocol {
    func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(vibrateButton)
        addSubview(mainStack)
        detailsContainer.addSubview(detailsLabel)
        propertiesContainer.addSubview(propertiesStack)
        exploreContainer.addSubview(exploreCell)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 192),
            imageView.heightAnchor.constraint(equalToConstant: 156),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            vibrateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            vibrateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vibrateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            vibrateButton.heightAnchor.constraint(equalToConstant: 48),
            
            mainStack.topAnchor.constraint(equalTo: vibrateButton.bottomAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 16),
            detailsLabel.bottomAnchor.constraint(equalTo: detailsContainer.bottomAnchor, constant: -16),
            detailsLabel.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 20),
            detailsLabel.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -20),
            
            propertiesStack.topAnchor.constraint(equalTo: propertiesContainer.topAnchor, constant: 16),
            propertiesStack.bottomAnchor.constraint(equalTo: propertiesContainer.bottomAnchor, constant: -16),
            propertiesStack.leadingAnchor.constraint(equalTo: propertiesContainer.leadingAnchor, constant: 20),
            propertiesStack.trailingAnchor.constraint(equalTo: propertiesContainer.trailingAnchor, constant: -20),
            
            exploreCell.topAnchor.constraint(equalTo: exploreContainer.topAnchor),
            exploreCell.bottomAnchor.constraint(equalTo: exploreContainer.bottomAnchor),
            exploreCell.leadingAnchor.constraint(equalTo: exploreContainer.leadingAnchor),
            exploreCell.trailingAnchor.constraint(equalTo: exploreContainer.trailingAnchor),
            exploreContainer.heightAnchor.constraint(equalToConstant: 156)
        ])
    }
}
