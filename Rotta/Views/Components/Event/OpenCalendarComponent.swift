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
    
    private lazy var firstDay: TwoEventDayComponent = {
        var info = TwoEventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.dayName = "SEX"
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
        info.dayName = "SAB"
        info.dayNumber = "29"
        info.eventTitle = "Corrida Sprint"
        info.eventTime = "08:30 - 09:30"
        return info
    }()
    
    private lazy var fourthEventInfo: EventDayComponent = {
        var info = EventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.dayName = "DOM"
        info.dayNumber = "30"
        info.eventTitle = "Corrida Principal"
        info.eventTime = "08:30 - 09:30"
        return info
    }()
    
    // Background container view with corner radius and clipping
    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // Background image view para a imagem de background
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "lusail-international-circuit")
        return imageView
    }()
    
    private lazy var eventCalendarStack: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [eventTitle, firstDay, thirdEventInfo, fourthEventInfo])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        gradient.layer.cornerRadius = 16
        gradient.clipsToBounds = true
        return gradient
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addGradient()
    }
    
    @objc func addGradient() {
        DispatchQueue.main.async {
            self.gradientView.addGradientCalendar()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OpenCalendarComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(backgroundContainer)
        backgroundImageView.addSubview(gradientView)
        backgroundContainer.addSubview(backgroundImageView)
        backgroundContainer.addSubview(eventCalendarStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gradientView.topAnchor.constraint(equalTo: self.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            backgroundImageView.topAnchor.constraint(equalTo: gradientView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),

            eventCalendarStack.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 16),
            eventCalendarStack.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
            eventCalendarStack.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -16),
            eventCalendarStack.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -16),
        ])
    }
}

