//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarViewController: UIViewController {

    private var currentFormula: FormulaType = .formula2

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
        var event = OpenCalendarComponent()
        event.translatesAutoresizingMaskIntoConstraints = false

        return event
    }()

    private let eventService = EventService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()

        currentFormula = UserPreferencesManager.shared.getSelectedFormula()
        customCalendarView.currentFormula = currentFormula

        setupTodaySelection()
    }

    private func setupTodaySelection() {
        let today = Date()

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.loadEventsForToday(today)
        }
    }

    private func loadEventsForToday(_ date: Date) {
        Task {
            let filteredEvents = await eventService.getEvents(
                for: currentFormula
            )
            let eventsOfTheDay = filteredEvents.filter { event in
                guard let eventDate = event.date else { return false }
                return Calendar.current.isDate(eventDate, inSameDayAs: date)
            }

            if let roundNumber = eventsOfTheDay.first?.roundNumber {
                let allEvents = await eventService.getEvents(
                    for: currentFormula
                )
                let eventsOfRound = allEvents.filter {
                    $0.roundNumber == roundNumber
                }

                await MainActor.run {
                    self.event.update(with: eventsOfRound)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadEventsForFormula(currentFormula)
    }

    private func loadEventsForFormula(_ formula: FormulaType) {
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)

            await MainActor.run {
                customCalendarView.updateEvents(filteredEvents, for: formula)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        customCalendarView.selectTodayManually()
    }
}

extension CalendarViewController: CalendarCollectionViewDelegate {
    func didSelectDate(_ date: Date) {
        Task {
            let filteredEvents = await eventService.getEvents(
                for: currentFormula
            )
            let eventsOfTheDay = filteredEvents.filter { event in
                guard let eventDate = event.date else { return false }
                return Calendar.current.isDate(eventDate, inSameDayAs: date)
            }

            guard let roundNumber = eventsOfTheDay.first?.roundNumber else {
                return
            }

            let allEvents = await eventService.getEvents(for: currentFormula)
            let eventsOfRound = allEvents.filter {
                $0.roundNumber == roundNumber
            }

            DispatchQueue.main.async {
                self.event.update(with: eventsOfRound)
            }
        }
    }
}

extension CalendarViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(customCalendarView)
        contentView.addSubview(event)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            customCalendarView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            customCalendarView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0
            ),
            customCalendarView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -0
            ),
            customCalendarView.heightAnchor.constraint(equalToConstant: 470),

            event.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0
            ),
            event.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -0
            ),
            event.topAnchor.constraint(
                equalTo: customCalendarView.bottomAnchor,
                constant: 20
            ),
            event.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 0
            ),

        ])
    }
}

extension CalendarViewController: FormulaFilterable {
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
