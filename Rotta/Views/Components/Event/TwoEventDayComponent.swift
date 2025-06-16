//
//  TwoEventDayComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 13/06/25.
//


import UIKit

class TwoEventDayComponent: UIView {
    
    // MARK: - WeekDay
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Subtitle2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Number Day
    private lazy var numberDayLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Day name and number stack
    private lazy var dayNumberStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [weekDayLabel, numberDayLabel])
        stack.axis = .vertical
        stack.spacing = 0
        stack.setContentHuggingPriority(.required, for: .horizontal)
        stack.setContentCompressionResistancePriority(.required, for: .horizontal)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - First Event
    private lazy var firstEvent: EventInfoComponent = {
        let event = EventInfoComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    // MARK: - Second Event
    private lazy var secondEvent: EventInfoComponent = {
        let event = EventInfoComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    // MARK: - Events Stack
    private lazy var eventsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstEvent, separator, secondEvent])
        stack.axis = .vertical
        stack.spacing = 4
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Horizontal content stack
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dayNumberStack, eventsStack])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .firstBaseline
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Background container
    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Separator Line
    lazy var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .end
        return separator
    }()
    
    // MARK: - Properties
    var dayName: String? {
        didSet { weekDayLabel.text = dayName }
    }

    var dayNumber: String? {
        didSet { numberDayLabel.text = dayNumber }
    }
    
    var firstEventTitle: String? {
        didSet { firstEvent.title = firstEventTitle }
    }
    
    var firstEventTime: String? {
        didSet { firstEvent.time = firstEventTime }
    }
    
    var secondEventTitle: String? {
        didSet { secondEvent.title = secondEventTitle }
    }
    
    var secondEventTime: String? {
        didSet { secondEvent.time = secondEventTime }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TwoEventDayComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(contentStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundContainer.topAnchor.constraint(equalTo: topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 12),
            contentStack.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -12),
            contentStack.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -12),

            separator.heightAnchor.constraint(equalToConstant: 0.50),
            
            dayNumberStack.topAnchor.constraint(equalTo: firstEvent.topAnchor)
        ])
    }
}
