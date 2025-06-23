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
        let events = await eventService.getAll().sorted { ($0.date ?? Date()) < ($1.date ?? Date()) }
        
        guard !events.isEmpty else { return }
        
        if let firstEvent = events.first {
            eventTitle.raceNumber = "Rodada \(firstEvent.roundNumber)"
            eventTitle.flag = events.first?.country.getCountryFlag()
            eventTitle.countryName = firstEvent.country
        }
        
        if let day = events.first?.date {
            let sameDayEvents = await eventService.getOnDate(day).sorted {
                ($0.startTime) < ($1.startTime)
            }
            
            if sameDayEvents.count >= 2 {
                let first = sameDayEvents[0]
                let second = sameDayEvents[1]
                
                let calendar = Calendar.current
                firstDay.dayName = day.formatted(.dateTime.weekday(.abbreviated)).uppercased()
                firstDay.dayNumber = "\(calendar.component(.day, from: day))"
                firstDay.firstEventTitle = first.name
                firstDay.firstEventTime = "\((first.startTime)) - \((first.endTime))"
                firstDay.secondEventTitle = second.name
                firstDay.secondEventTime = "\((second.startTime)) - \((second.endTime))"
            }
        }
        
        if events.count >= 3 {
            let third = events[2]
            if let date = third.date {
                let calendar = Calendar.current
                thirdEventInfo.dayName = date.formatted(.dateTime.weekday(.abbreviated)).uppercased()
                thirdEventInfo.dayNumber = "\(calendar.component(.day, from: date))"
                thirdEventInfo.eventTitle = third.name
                thirdEventInfo.eventTime = "\((third.startTime)) - \((third.endTime))"
            }
        }
        if events.count >= 4 {
            let fourth = events[3]
            if let date = fourth.date {
                let calendar = Calendar.current
                fourthEventInfo.dayName = date.formatted(.dateTime.weekday(.abbreviated)).uppercased()
                fourthEventInfo.dayNumber = "\(calendar.component(.day, from: date))"
                fourthEventInfo.eventTitle = fourth.name
                fourthEventInfo.eventTime = "\((fourth.startTime)) - \((fourth.endTime))"
            }
        }
        
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


//extension OpenCalendarComponent {
//    func update(with events: [EventModel]) {
//        guard let first = events.first else { return }
//        
//        // 🔑 1) Atualiza a parte do título da rodada e país
//        self.eventTitle.raceNumber = "Rodada \(first.roundNumber)"
//        self.eventTitle.flag =  events.first?.country.getCountryFlag()// ou mapeie baseado em first.country
//        self.eventTitle.countryName = first.country
//        
//        // 🔑 2) Ordena os eventos por data + hora
//        let sortedEvents = events.sorted {
//            guard let date1 = $0.date, let date2 = $1.date else { return false }
//            if date1 != date2 {
//                return date1 < date2
//            } else {
//                let start1 = $0.startTime
//                let start2 = $1.startTime
//                return start1 < start2
//            }
//        }
//
//        // 🔑 3) Agrupa por data
//        let grouped = Dictionary(grouping: sortedEvents) { event -> Date in
//            let calendar = Calendar.current
//            return calendar.startOfDay(for: event.date ?? Date())
//        }
//            .sorted { $0.key < $1.key }
//        
//        // 🔑 4) Limpa todos
//        self.firstDay.dayName = ""
//        self.firstDay.dayNumber = ""
//        self.firstDay.firstEventTitle = ""
//        self.firstDay.firstEventTime = ""
//        self.firstDay.secondEventTitle = ""
//        self.firstDay.secondEventTime = ""
//        
//        self.thirdEventInfo.dayName = ""
//        self.thirdEventInfo.dayNumber = ""
//        self.thirdEventInfo.eventTitle = ""
//        self.thirdEventInfo.eventTime = ""
//        
//        self.fourthEventInfo.dayName = ""
//        self.fourthEventInfo.dayNumber = ""
//        self.fourthEventInfo.eventTitle = ""
//        self.fourthEventInfo.eventTime = ""
//        
//        let calendar = Calendar.current
//        
//        // 🔑 5) Preenche os slots
//        if grouped.indices.contains(0) {
//            let day0Events = grouped[0].value.sorted { ($0.startTime) < ($1.startTime) }
//            if day0Events.count >= 2 {
//                let firstEvent = day0Events[0]
//                let secondEvent = day0Events[1]
//                
//                self.firstDay.dayName = firstEvent.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
//                self.firstDay.dayNumber = "\(calendar.component(.day, from: firstEvent.date ?? Date()))"
//                self.firstDay.firstEventTitle = firstEvent.name
//                self.firstDay.firstEventTime = "\((firstEvent.startTime)) - \((firstEvent.endTime))"
//                
//                self.firstDay.secondEventTitle = secondEvent.name
//                self.firstDay.secondEventTime = "\((secondEvent.startTime)) - \((secondEvent.endTime))"
//            } else if day0Events.count == 1 {
//                let event = day0Events[0]
//                self.thirdEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
//                self.thirdEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
//                self.thirdEventInfo.eventTitle = event.name
//                self.thirdEventInfo.eventTime = "\((event.startTime)) - \((event.endTime))"
//            }
//        }
//        
//        if grouped.indices.contains(1) {
//            let day1Events = grouped[1].value.sorted { ($0.startTime) < ($1.startTime) }
//            let event = day1Events[0]
//            self.thirdEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
//            self.thirdEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
//            self.thirdEventInfo.eventTitle = event.name
//            self.thirdEventInfo.eventTime = "\((event.startTime)) - \((event.endTime))"
//        }
//        
//        if grouped.indices.contains(2) {
//            let day2Events = grouped[2].value.sorted { ($0.startTime) < ($1.startTime) }
//            let event = day2Events[0]
//            self.fourthEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
//            self.fourthEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
//            self.fourthEventInfo.eventTitle = event.name
//            self.fourthEventInfo.eventTime = "\((event.startTime)) - \((event.endTime))"
//        }
//    }
//}
extension OpenCalendarComponent {
    func update(with events: [EventModel]) {
        guard let first = events.first else { return }

        // 🔑 1) Atualiza título da rodada e país
        self.eventTitle.raceNumber = "Rodada \(first.roundNumber)"
        self.eventTitle.flag = first.country.getCountryFlag()
        self.eventTitle.countryName = first.country

        // 🔑 2) Agrupa por data (ordena apenas por date, sem mexer em startTime)
        let grouped = Dictionary(grouping: events) { event -> Date in
            let calendar = Calendar.current
            return calendar.startOfDay(for: event.date ?? Date())
        }
        .sorted { $0.key < $1.key }

        // 🔑 3) Limpa todos os slots
        self.firstDay.dayName = ""
        self.firstDay.dayNumber = ""
        self.firstDay.firstEventTitle = ""
        self.firstDay.firstEventTime = ""
        self.firstDay.secondEventTitle = ""
        self.firstDay.secondEventTime = ""

        self.thirdEventInfo.dayName = ""
        self.thirdEventInfo.dayNumber = ""
        self.thirdEventInfo.eventTitle = ""
        self.thirdEventInfo.eventTime = ""

        self.fourthEventInfo.dayName = ""
        self.fourthEventInfo.dayNumber = ""
        self.fourthEventInfo.eventTitle = ""
        self.fourthEventInfo.eventTime = ""

        let calendar = Calendar.current

        // 🔑 4) Preenche os slots usando os horários como estão
        if grouped.indices.contains(0) {
            let day0Events = grouped[0].value // não ordena por startTime
            if day0Events.count >= 2 {
                let firstEvent = day0Events[0]
                let secondEvent = day0Events[1]

                self.firstDay.dayName = firstEvent.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
                self.firstDay.dayNumber = "\(calendar.component(.day, from: firstEvent.date ?? Date()))"
                self.firstDay.firstEventTitle = firstEvent.name
                self.firstDay.firstEventTime = "\(firstEvent.startTime) - \(firstEvent.endTime)"

                self.firstDay.secondEventTitle = secondEvent.name
                self.firstDay.secondEventTime = "\(secondEvent.startTime) - \(secondEvent.endTime)"
            } else if day0Events.count == 1 {
                let event = day0Events[0]
                self.thirdEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
                self.thirdEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
                self.thirdEventInfo.eventTitle = event.name
                self.thirdEventInfo.eventTime = "\(event.startTime) - \(event.endTime)"
            }
        }

        if grouped.indices.contains(1) {
            let day1Events = grouped[1].value
            let event = day1Events[0]
            self.thirdEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
            self.thirdEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
            self.thirdEventInfo.eventTitle = event.name
            self.thirdEventInfo.eventTime = "\(event.startTime) - \(event.endTime)"
        }

        if grouped.indices.contains(2) {
            let day2Events = grouped[2].value
            let event = day2Events[0]
            self.fourthEventInfo.dayName = event.date?.formatted(.dateTime.weekday(.abbreviated)).uppercased() ?? ""
            self.fourthEventInfo.dayNumber = "\(calendar.component(.day, from: event.date ?? Date()))"
            self.fourthEventInfo.eventTitle = event.name
            self.fourthEventInfo.eventTime = "\(event.startTime) - \(event.endTime)"
        }
    }
}
