//
//  EventNameComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 11/06/25.
//

import UIKit

class EventInfoComponent: UIView {

    //MARK: Event Icon
    private lazy var eventIcon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "circle.fill")
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return icon
    }()
    
    //MARK: Event Title
    private lazy var eventTitle: UILabel = {
        var label = UILabel()
        label.font = Fonts.Headline
        label.textColor = .white
        
        return label
    }()
    
    private lazy var iconTitleStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [eventIcon, eventTitle])
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()

    private lazy var eventTime: UILabel = {
        var label = UILabel()
        label.font = Fonts.BodyRegular
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Event Stack
    private lazy var eventInfoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [iconTitleStack, eventTime])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 3
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()

    
    //MARK: Properties
    var color: UIColor? {
        didSet {
            eventIcon.tintColor = color
        }
    }
    
    var title: String? {
        didSet {
            eventTitle.text = title
        }
    }

    var time: String? {
        didSet {
            eventTime.text = time
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


extension EventInfoComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(eventInfoStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            eventInfoStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            eventInfoStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            eventInfoStack.topAnchor.constraint(equalTo: self.topAnchor),
            eventInfoStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),


            eventIcon.widthAnchor.constraint(equalToConstant: 8),
            eventIcon.heightAnchor.constraint(equalToConstant: 8),
            eventIcon.centerYAnchor.constraint(equalTo: eventTitle.firstBaselineAnchor),

        ])
    }
}
