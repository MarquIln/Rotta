//
//  OpenCalendarComponent.swift
//  Rotta
//
//  Created by Maria Santellano on 11/06/25.
//

import UIKit

class OpenCalendarComponent: UIView {
    
    private let eventService = EventService()
    
    // MARK: - Components
    
    private lazy var eventTitle: EventNameComponent = {
        var event = EventNameComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    private lazy var firstDay: TwoEventDayComponent = {
        var info = TwoEventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    private lazy var thirdEventInfo: EventDayComponent = {
        var info = EventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    private lazy var fourthEventInfo: EventDayComponent = {
        var info = EventDayComponent()
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    private lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addGradient()
        Task {
            await loadEvents()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addGradient() {
        DispatchQueue.main.async {
            self.gradientView.addGradientCalendar()
        }
    }
    
    // MARK: - Load Data
    
    private func loadEvents() async {
        let allEvents = await eventService.getAll()
        configure(with: allEvents)
    }
    
    // MARK: - Configure
    
    private func configure(with events: [EventModel]) {
        let now = Date()
        let calendar = Calendar.current

        let sortedEvents = events.sorted { ($0.date ?? Date()) < ($1.date ?? Date()) }
        guard !sortedEvents.isEmpty else { return }

        let defaultEvent = sortedEvents.first(where: { ($0.date ?? Date()) >= now }) ?? sortedEvents.first!

        let grouped = Dictionary(grouping: sortedEvents) { event in
            calendar.startOfDay(for: event.date ?? Date())
        }.sorted { $0.key < $1.key }

        let defaultDay = calendar.startOfDay(for: defaultEvent.date ?? Date())
        guard let defaultDayGroup = grouped.first(where: { $0.key == defaultDay }) else { return }
        let defaultDayEvents = defaultDayGroup.value.sorted { $0.startTime < $1.startTime }

        eventTitle.raceNumber = "Rodada \(defaultEvent.roundNumber)"
        eventTitle.flag = defaultEvent.country.getCountryFlag()
        eventTitle.countryName = defaultEvent.country

        if defaultDayEvents.count >= 2 {
            let first = defaultDayEvents[0]
            let second = defaultDayEvents[1]
            firstDay.dayName = defaultDay.formatted(.dateTime.weekday(.abbreviated)).uppercased()
            firstDay.dayNumber = "\(calendar.component(.day, from: defaultDay))"
            firstDay.firstEventTitle = first.name
            firstDay.firstEventTime = "\(first.startTime) - \(first.endTime)"
            firstDay.secondEventTitle = second.name
            firstDay.secondEventTime = "\(second.startTime) - \(second.endTime)"
        } else if defaultDayEvents.count == 1 {
            let only = defaultDayEvents[0]
            firstDay.dayName = defaultDay.formatted(.dateTime.weekday(.abbreviated)).uppercased()
            firstDay.dayNumber = "\(calendar.component(.day, from: defaultDay))"
            firstDay.firstEventTitle = only.name
            firstDay.firstEventTime = "\(only.startTime) - \(only.endTime)"
            firstDay.secondEventTitle = ""
            firstDay.secondEventTime = ""
        } else {
            firstDay.dayName = ""
            firstDay.dayNumber = ""
            firstDay.firstEventTitle = ""
            firstDay.firstEventTime = ""
            firstDay.secondEventTitle = ""
            firstDay.secondEventTime = ""
        }

        let otherDays = grouped.filter { $0.key != defaultDay }

        if otherDays.indices.contains(0) {
            let day1 = otherDays[0]
            let eventsDay1 = day1.value.sorted { $0.startTime < $1.startTime }
            let event = eventsDay1[0]
            thirdEventInfo.dayName = day1.key.formatted(.dateTime.weekday(.abbreviated)).uppercased()
            thirdEventInfo.dayNumber = "\(calendar.component(.day, from: day1.key))"
            thirdEventInfo.eventTitle = event.name
            thirdEventInfo.eventTime = "\(event.startTime) - \(event.endTime)"
        } else {
            thirdEventInfo.dayName = ""
            thirdEventInfo.dayNumber = ""
            thirdEventInfo.eventTitle = ""
            thirdEventInfo.eventTime = ""
        }

        if otherDays.indices.contains(1) {
            let day2 = otherDays[1]
            let eventsDay2 = day2.value.sorted { $0.startTime < $1.startTime }
            let event = eventsDay2[0]
            fourthEventInfo.dayName = day2.key.formatted(.dateTime.weekday(.abbreviated)).uppercased()
            fourthEventInfo.dayNumber = "\(calendar.component(.day, from: day2.key))"
            fourthEventInfo.eventTitle = event.name
            fourthEventInfo.eventTime = "\(event.startTime) - \(event.endTime)"
        } else {
            fourthEventInfo.dayName = ""
            fourthEventInfo.dayNumber = ""
            fourthEventInfo.eventTitle = ""
            fourthEventInfo.eventTime = ""
        }
    }
    
    // MARK: - External Update
    
    func update(with events: [EventModel]) {
        configure(with: events)
    }
}

// MARK: - ViewCodeProtocol

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
