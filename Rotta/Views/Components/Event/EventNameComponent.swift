//
//  EventNameComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 11/06/25.
//

import UIKit

class EventNameComponent: UIView {
    
    //MARK: Race Number
    private lazy var raceNumberLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.Subtitle1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Country Flag
    private lazy var countryFlag: UILabel = {
        var flag = UILabel()
        flag.translatesAutoresizingMaskIntoConstraints = false
        flag.contentMode = .scaleAspectFit
        flag.setContentHuggingPriority(.required, for: .horizontal)
        flag.setContentCompressionResistancePriority(.required, for: .horizontal)

        return flag
    }()
    
    //MARK: Country Name
    private lazy var countryNameLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Country info Stack
    private lazy var countryStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [countryFlag, countryNameLabel])
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: Separator Line
    lazy var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .dividerSecondary
        return separator
    }()
    
    //MARK: Race Event Stack
    private lazy var raceEventStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [raceNumberLabel, countryStack])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    //MARK: Properties
    var raceNumber: String? {
        didSet {
            raceNumberLabel.text = raceNumber
        }
    }

    var flag: String? {
        didSet {
            countryFlag.text = flag
        }
    }
    
    var countryName: String? {
        didSet {
            countryNameLabel.text = countryName
        }
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EventNameComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(raceEventStack)
        addSubview(separator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            raceEventStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            raceEventStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            raceEventStack.topAnchor.constraint(equalTo: self.topAnchor),
            raceEventStack.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -12),
            
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
}
