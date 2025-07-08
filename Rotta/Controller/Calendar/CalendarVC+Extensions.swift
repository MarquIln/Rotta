//
//  CalendarVC+Extensions.swift
//  Rotta
//
//  Created by Marcos on 07/07/25.
//


import UIKit

extension CalendarVC: CalendarCollectionViewDelegate {
    func didChangeMonth(_ month: Date) {}
    
    func didSelectDate(_ date: Date) {
        eventManager.loadEventsForDate(date, formula: currentFormula) { [weak self] events in
            self?.event.update(with: events)
        }
    }
}

extension CalendarVC: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(customCalendarView)
        contentView.addSubview(event)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            customCalendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            customCalendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customCalendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customCalendarView.heightAnchor.constraint(equalToConstant: 470),
            
            event.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            event.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            event.topAnchor.constraint(equalTo: customCalendarView.bottomAnchor, constant: 20),
            event.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension CalendarVC: FormulaFilterable {
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)
            await MainActor.run {
                customCalendarView.updateEvents(filteredEvents, for: formula)
                customCalendarView.clearCacheAndReload()
                event.update(with: filteredEvents)
            }
        }
    }
}

class CalendarEventManager {
    private let eventService = EventService()
    
    func loadEventsForDate(_ date: Date, formula: FormulaType, completion: @escaping ([EventModel]) -> Void) {
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)
            let eventsOfTheDay = filteredEvents.filter { event in
                guard let eventDate = event.date else { return false }
                return Calendar.current.isDate(eventDate, inSameDayAs: date)
            }
            
            guard let roundNumber = eventsOfTheDay.first?.roundNumber else {
                await MainActor.run {
                    completion([])
                }
                return
            }
            
            let allEvents = await eventService.getEvents(for: formula)
            let eventsOfRound = allEvents.filter { $0.roundNumber == roundNumber }
            
            await MainActor.run {
                completion(eventsOfRound)
            }
        }
    }
}
