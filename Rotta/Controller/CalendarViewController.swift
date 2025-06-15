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
        calendar.backgroundColor = .secondaryGray
        calendar.layer.cornerRadius = 20
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    
    private lazy var event: OpenCalendarComponent = {
        var event = OpenCalendarComponent()
        event.translatesAutoresizingMaskIntoConstraints = false
        
        return event
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
    }
}

extension CalendarViewController: CalendarCollectionViewDelegate {
    func didSelectDate(_ date: Date) {
        print("Data selecionada: \(date)")
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
//        NSLayoutConstraint.activate([
//            customCalendarView.topAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.topAnchor,
//                constant: 50
//            ),
//            customCalendarView.leadingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
//                constant: 16
//            ),
//            customCalendarView.trailingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                constant: -16
//            ),
//            customCalendarView.heightAnchor.constraint(equalToConstant: 500),
//            
//            label.topAnchor.constraint(
//                equalTo: customCalendarView.bottomAnchor,
//                constant: 16
//            ),
//            label.centerXAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.centerXAnchor
//            )
//        ])
        
        NSLayoutConstraint.activate([
                   // ScrollView ocupa toda a tela
                   scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                   scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                   scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

                   // ContentView dentro da ScrollView
                   contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                   contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                   contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                   contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

                   // MUITO IMPORTANTE: contentView precisa ter largura igual à scrollView
                   contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

                   // Seus componentes dentro da contentView
                   customCalendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
                   customCalendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   customCalendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   customCalendarView.heightAnchor.constraint(equalToConstant: 500),

                   // contentView precisa de um bottom fixo: último elemento + padding
//                   label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                   
                   event.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   event.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   event.topAnchor.constraint(equalTo: customCalendarView.bottomAnchor, constant: 19),
                   event.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)

               ])
    }
}
