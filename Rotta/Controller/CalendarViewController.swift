//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarViewController: UIViewController {

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customCalendarView.preloadAllEvents()
    }
}

extension CalendarViewController: CalendarCollectionViewDelegate {
    func didSelectDate(_ date: Date) {
        print("Data selecionada: \(date)")

        Task {
            let eventsOfTheDay = await eventService.getOnDate(date)
            
            guard let roundNumber = eventsOfTheDay.first?.roundNumber else {
                print("Nenhum evento nesse dia")
                return
            }
            
            let allEvents = await eventService.getAll()
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
