//
//  OpenCalendarComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 11/06/25.
//

import UIKit

class OpenCalendarComponent: UIView {

    private lazy var eventTitle: EventNameComponent = {
        var event = EventNameComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.raceNumber = "Rodada 12"
        event.flag = "🇶🇦"
        event.countryName = "Lusail, Qatar"

        return event
    }()
    
//    private lazy var firstEventInfo: EventDayComponent = {
//        var info = EventDayComponent()
//        info.translatesAutoresizingMaskIntoConstraints = false
//        info.dayName = "Sex"
//        info.dayNumber = "28"
//        info.eventTitle = "Treino Livre"
//        info.eventTime = "08:00 - 09:00"
//                
////        info.backgroundColor = .gray
//        return info
//    }()
//    
//    private lazy var secondEventInfo: EventInfoComponent = {
//        var info = EventInfoComponent()
//        info.translatesAutoresizingMaskIntoConstraints = false
//        info.color = .red
//        
//        info.title = "Sessão de Qualificação"
//        info.time = "10:00 - 11:00"
//        
//        return info
//    }()
    
    
//    private lazy var twoEventsDay: UIStackView = {
//        var stack = UIStackView(arrangedSubviews: [firstEventInfo, secondEventInfo])
//        stack.axis = .vertical
//        
//        
//        return stack
//    }()

    private lazy var firstDay: TwoEventDayComponent = {
        var info = TwoEventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.dayName = "Sex"
        info.dayNumber = "28"
        info.firstEventTitle = "Treino Livre"
        info.firstEventTime = "08:00 - 09:00"
        info.secondEventTitle = "Qualificação"
        info.secondEventTime = "10:00 - 11:00"
        
        
        return info
    }()

    
    private lazy var thirdEventInfo: EventDayComponent = {
        var info = EventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.dayName = "Sab"
        info.dayNumber = "29"
        
        info.eventTitle = "Corrida Sprint"
        info.eventTime = "08:30 - 09:30"
        
        return info
    }()
    
    private lazy var fourthEventInfo: EventDayComponent = {
        var info = EventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.dayName = "Dom"
        info.dayNumber = "30"
        
        info.eventTitle = "Corrida Principal"
        info.eventTime = "08:30 - 09:30"
        
        return info
    }()
    
    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private lazy var eventCalendarStack: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [eventTitle, firstDay, thirdEventInfo, fourthEventInfo])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OpenCalendarComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(eventCalendarStack)
    }

    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundContainer.topAnchor.constraint(equalTo: topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            eventCalendarStack.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 16),
            eventCalendarStack.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 16),
            eventCalendarStack.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -16),
            eventCalendarStack.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -16)
        ])

    }
}

