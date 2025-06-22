//
//  HeightAndBornComponent.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 22/06/25.
//
import UIKit
class HeightAndBornComponent: UIView {
    var height: String = ""
    var birthDate: String = ""
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Altura \(height)m"
        label.textColor = .labelsPrimary
        label.font = Fonts.BodyRegular
        return label
    }()
    
    lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Nascido em \(birthDate)"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle2
        return label
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dividerPrimary
        return view
    }()
    
    init(height: String, birthDate: String) {
        self.height = height
        self.birthDate = birthDate
        
        super.init(frame: .zero)
        
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HeightAndBornComponent: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(heightLabel)
        addSubview(birthDateLabel)
        addSubview(divider)
    }
    func setupConstraints() {
        
    }
}
