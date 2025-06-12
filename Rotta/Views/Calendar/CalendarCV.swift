//
//  CalendarCV.swift
//  Rotta
//
//  Created by Marcos on 11/06/25.
//

import UIKit

protocol CalendarCollectionViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
    func didChangeMonth(_ date: Date)
}

class CalendarCollectionView: UIView {
    weak var delegate: CalendarCollectionViewDelegate?
    
    var currentDate = Date()
    var selectedDate: Date?
    let calendar = Calendar.current
    var days: [Date?] = []
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textAlignment = .right
        label.textColor = .labelPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weekdayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let weekdays = ["D", "S", "T", "Q", "Q", "S", "S"]
        weekdays.enumerated().forEach { index, day in
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = (index == 0 || index == 5 || index == 6) ? .labelPrimary : .systemGray
            stack.addArrangedSubview(label)
        }
        
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        
        let calendar = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendar.backgroundColor = .clear
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        calendar.showsVerticalScrollIndicator = false
        return calendar
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        return gesture
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        updateCalendar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        updateCalendar()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(headerLabel)
        addSubview(weekdayStackView)
        addSubview(collectionView)
        
        addGestureRecognizer(panGesture)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            weekdayStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            weekdayStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            weekdayStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            collectionView.topAnchor.constraint(equalTo: weekdayStackView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        if gesture.state == .ended {
            if translation.x > 50 {
                changeMonth(-1)
            } else if translation.x < -50 {
                changeMonth(1)
            }
        }
    }
    
    private func changeMonth(_ direction: Int) {
        currentDate = calendar.date(byAdding: .month, value: direction, to: currentDate) ?? currentDate
        updateCalendar()
        delegate?.didChangeMonth(currentDate)
    }
    
    private func updateCalendar() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "MMM"
        headerLabel.text = formatter.string(from: currentDate).capitalized
        
        generateDaysInMonth()
        
        UIView.transition(with: collectionView, duration: 0.1, options: .transitionCrossDissolve) {
            self.collectionView.reloadData()
        }
    }
    
    private func generateDaysInMonth() {
        days.removeAll()
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else { return }
        let firstOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)

        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        let numberOfDays = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 0
        for day in 1...numberOfDays {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(date)
            }
        }
        
        while days.count % 7 != 0 {
            days.append(nil)
        }
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
        collectionView.reloadData()
    }
}
