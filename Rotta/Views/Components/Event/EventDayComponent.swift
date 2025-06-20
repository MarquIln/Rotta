//
//  EventDayComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 10/06/25.
//

import UIKit

class EventDayComponent: UIView {
    
    //MARK: WeekDay
    private lazy var weekDayLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Number Day
    private lazy var numberDayLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Day name and number stack
    private lazy var dayNumberStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [weekDayLabel, numberDayLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: Event Name
    private lazy var eventName: EventInfoComponent = {
        var event = EventInfoComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.color = .cyan
        
        return event
    }()
    
    //MARK: Event Stack
    private lazy var eventStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dayNumberStack, eventName])
        stack.backgroundColor = .backgroundSecondary
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 12
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        
        return stack
    }()
    
    //MARK: Properties
    var dayName: String? {
        didSet {
            weekDayLabel.text = dayName
        }
    }

    var dayNumber: String? {
        didSet {
            numberDayLabel.text = dayNumber
        }
    }
    
    var eventTitle: String? {
        didSet {
            eventName.title = eventTitle
        }
    }
    
    var eventTime: String? {
        didSet {
            eventName.time = eventTime
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


extension EventDayComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(eventStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            eventStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            eventStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            eventStack.topAnchor.constraint(equalTo: self.topAnchor),
            eventStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),



        ])
    }
}

