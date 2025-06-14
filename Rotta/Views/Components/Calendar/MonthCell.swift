//
//  MonthCell.swift
//  Rotta
//
//  Created by Marcos on 14/06/25.
//

import UIKit

protocol MonthCellDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

class MonthCell: UICollectionViewCell {
    weak var delegate: MonthCellDelegate?
    
    var month: Date = Date()
    var selectedDate: Date?
    var days: [Date?] = []
    let calendar = Calendar.current
    
    private lazy var daysCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(daysCollectionView)
        
        NSLayoutConstraint.activate([
            daysCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            daysCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            daysCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            daysCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with month: Date, selectedDate: Date?, delegate: MonthCellDelegate?) {
        self.month = month
        self.selectedDate = selectedDate
        self.delegate = delegate
        
        generateDaysInMonth()
        daysCollectionView.reloadData()
    }
    
    func updateSelectedDate(_ selectedDate: Date?) {
        self.selectedDate = selectedDate
        daysCollectionView.reloadData()
    }
    
    private func generateDaysInMonth() {
        days.removeAll()
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return }
        
        let firstOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)

        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        let numberOfDays = calendar.range(of: .day, in: .month, for: month)?.count ?? 0
        
        for day in 1...numberOfDays {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(date)
            }
        }
        
        while days.count % 7 != 0 {
            days.append(nil)
        }
    }
}
