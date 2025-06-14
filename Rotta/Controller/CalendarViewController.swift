//
//  CalendarViewController.swift
//  Rotta
//
//  Created by Sofia on 10/06/25.
//

import UIKit

class CalendarViewController: UIViewController {
    private lazy var customCalendarView: CalendarCollectionView = {
        let calendar = CalendarCollectionView()
        calendar.delegate = self
        calendar.backgroundColor = .secondaryGray
        calendar.layer.cornerRadius = 20
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "F1 AMANHA"
        label.textColor = .yellowPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        view.addSubview(customCalendarView)
        view.addSubview(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            customCalendarView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),
            customCalendarView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            customCalendarView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            customCalendarView.heightAnchor.constraint(equalToConstant: 500),
            
            label.topAnchor.constraint(
                equalTo: customCalendarView.bottomAnchor,
                constant: 16
            ),
            label.centerXAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerXAnchor
            )
        ])
    }
}
