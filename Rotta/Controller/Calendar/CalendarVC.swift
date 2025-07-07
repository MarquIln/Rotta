//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarVC: UIViewController {
    var currentFormula: FormulaType = .formula2
    let eventService = EventService()
    let eventManager = CalendarEventManager()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var customCalendarView: CalendarCollectionView = {
        let calendar = CalendarCollectionView()
        calendar.delegate = self
        calendar.backgroundColor = .fillsUnselected
        calendar.layer.cornerRadius = 20
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    lazy var event: OpenCalendarComponent = {
        let event = OpenCalendarComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFormula = Database.shared.getSelectedFormula()
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
