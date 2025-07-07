//
//  CarComponentDetails.swift
//  Rotta
//
//  Created by Marcos on 25/06/25.
//

import UIKit
import AudioToolbox
import AVFoundation

class CarComponentDetails: UIView {
    
    var component: ComponentModel? {
        didSet {
            configure(with: component!)
        }
    }
    
    private var vibrateTimer: Timer?
    private var impactFeedback: UIImpactFeedbackGenerator?
    private var currentIntensity: Float = 0.1
    private var intensityStep: Float = 0.1
    private var audioPlayer: AVAudioPlayer?
    
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
        
        button.setTitle("Mantenha pressionado para acelerar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.BodyRegular
        
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        
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
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    @objc private func startVibrating() {
        impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback?.prepare()
        
        currentIntensity = 0.1
        startComponentSpecificVibration()
        
        vibrateTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            self.currentIntensity = min(1.0, self.currentIntensity + self.intensityStep)
            self.impactFeedback?.impactOccurred(intensity: CGFloat(self.currentIntensity))
            
            if self.currentIntensity > 0.7 {
                self.impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            } else if self.currentIntensity > 0.4 {
                self.impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            } else {
                self.impactFeedback = UIImpactFeedbackGenerator(style: .light)
            }
            self.impactFeedback?.prepare()
        }
    }
    
    @objc private func stopVibrating() {
        vibrateTimer?.invalidate()
        vibrateTimer = nil
        
        let strongFeedback = UIImpactFeedbackGenerator(style: .heavy)
        strongFeedback.prepare()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            strongFeedback.impactOccurred(intensity: 1.0)
        }
        
        impactFeedback = nil
        currentIntensity = 0.1
        stopComponentSpecificVibration()
    }
    
    private func startComponentSpecificVibration() {
        guard let component = component else { return }
        
        switch component.name?.lowercased() {
        case let name where name?.contains("motor") == true || name?.contains("engine") == true:
            intensityStep = 0.15
            vibrateButton.f1EngineAnimation()
            imageView.f1EngineAnimation()
            playComponentSound("engine_sound")
            
        case let name where name?.contains("freio") == true || name?.contains("brake") == true:
            intensityStep = 0.2
            vibrateButton.f1BrakeAnimation()
            imageView.f1BrakeAnimation()
            playComponentSound("brake_sound")
            
        case let name where name?.contains("pneu") == true || name?.contains("tire") == true || name?.contains("roda") == true:
            intensityStep = 0.08
            vibrateButton.f1TireAnimation()
            imageView.f1TireAnimation()
            playComponentSound("tire_sound")
            
        case let name where name?.contains("asa") == true || name?.contains("wing") == true || name?.contains("aerodin") == true:
            intensityStep = 0.05
            vibrateButton.f1AeroAnimation()
            imageView.f1AeroAnimation()
            playComponentSound("aero_sound")
            
        case let name where name?.contains("suspensão") == true || name?.contains("suspension") == true:
            intensityStep = 0.12
            vibrateButton.f1SuspensionAnimation()
            imageView.f1SuspensionAnimation()
            playComponentSound("suspension_sound")
            
        case let name where name?.contains("câmbio") == true || name?.contains("gearbox") == true || name?.contains("transmissão") == true:
            intensityStep = 0.25
            vibrateButton.f1GearboxAnimation()
            imageView.f1GearboxAnimation()
            playComponentSound("gearbox_sound")
            
        default:
            intensityStep = 0.1
            vibrateButton.f1EngineAnimation()
            imageView.f1EngineAnimation()
            playComponentSound("default_sound")
        }
    }
    
    private func stopComponentSpecificVibration() {
        vibrateButton.stopAllF1Animations()
        imageView.stopAllF1Animations()
        audioPlayer?.stop()
        vibrateButton.backgroundColor = .rottaYellow
    }
    
    private func playComponentSound(_ soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else { 
            print("Som não encontrado: \(soundName)")
            return 
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.3
            audioPlayer?.play()
        } catch {
            print("Erro ao reproduzir som: \(error)")
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
