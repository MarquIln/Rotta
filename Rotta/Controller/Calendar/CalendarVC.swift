//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarVC: UIViewController {
    private var currentFormula: FormulaType = .formula2
    private let eventService = EventService()
    private let eventManager = CalendarEventManager()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var customCalendarView: CalendarCollectionView = {
        let calendar = CalendarCollectionView()
        calendar.delegate = self
        calendar.backgroundColor = .fillsUnselected
        calendar.layer.cornerRadius = 20
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var event: OpenCalendarComponent = {
        let event = OpenCalendarComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFormula = UserPreferencesManager.shared.getSelectedFormula()
        customCalendarView.currentFormula = currentFormula
        setup()
        setupTodaySelection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEventsForFormula(currentFormula)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customCalendarView.selectTodayManually()
    }
    
    private func setupTodaySelection() {
        let today = Date()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.eventManager.loadEventsForDate(today, formula: self.currentFormula) { [weak self] events in
                self?.event.update(with: events)
            }
        }
    }
    
    private func loadEventsForFormula(_ formula: FormulaType) {
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)
            await MainActor.run {
                customCalendarView.updateEvents(filteredEvents, for: formula)
            }
        }
    }
}

// MARK: - CalendarCollectionViewDelegate
extension CalendarVC: CalendarCollectionViewDelegate {
    func didChangeMonth(_ month: Date) {}
    
    func didSelectDate(_ date: Date) {
        eventManager.loadEventsForDate(date, formula: currentFormula) { [weak self] events in
            self?.event.update(with: events)
        }
    }
}

// MARK: - ViewCodeProtocol
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

// MARK: - FormulaFilterable
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

// MARK: - CalendarEventManager
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
