//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private var currentFormula: FormulaType?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
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
        
        // Inicializar com Formula 2 por padrão
        if currentFormula == nil {
            currentFormula = .formula2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Se uma fórmula específica está selecionada, carregue eventos filtrados
        if let formula = currentFormula {
            loadEventsForFormula(formula)
        } else {
            // Estado inicial: carregue eventos da Formula 2
            loadEventsForFormula(.formula2)
        }
    }
    
    private func loadEventsForFormula(_ formula: FormulaType) {
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)
            
            await MainActor.run {
                customCalendarView.updateEvents(filteredEvents)
            }
        }
    }
}

extension CalendarViewController: CalendarCollectionViewDelegate {
    func didSelectDate(_ date: Date) {
        print("Data selecionada: \(date)")

        Task {
            let eventsOfTheDay: [EventModel]
            
            // Use eventos filtrados se uma fórmula específica estiver selecionada
            if let formula = currentFormula {
                let filteredEvents = await eventService.getEvents(for: formula)
                eventsOfTheDay = filteredEvents.filter { event in
                    guard let eventDate = event.date else { return false }
                    return Calendar.current.isDate(eventDate, inSameDayAs: date)
                }
            } else {
                eventsOfTheDay = await eventService.getOnDate(date)
            }
            
            guard let roundNumber = eventsOfTheDay.first?.roundNumber else {
                print("Nenhum evento nesse dia")
                return
            }
            
            let allEvents: [EventModel]
            if let formula = currentFormula {
                allEvents = await eventService.getEvents(for: formula)
            } else {
                allEvents = await eventService.getAll()
            }
            
            let eventsOfRound = allEvents.filter { $0.roundNumber == roundNumber }
            
            DispatchQueue.main.async {
                self.event.update(with: eventsOfRound)
            }
        }
    }

    
    func didChangeMonth(_ date: Date) {
        print("Mês alterado para: \(date)")
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
                constant: 16
            ),
            customCalendarView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            customCalendarView.heightAnchor.constraint(equalToConstant: 500),

                   event.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   event.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   event.topAnchor.constraint(equalTo: customCalendarView.bottomAnchor, constant: 20),
                   event.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)

        ])
    }
}

extension CalendarViewController: FormulaFilterable {
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        
        Task {
            let filteredEvents = await eventService.getEvents(for: formula)
            
            await MainActor.run {
                customCalendarView.updateEvents(filteredEvents)
                event.update(with: filteredEvents)
            }
        }
    }
}
