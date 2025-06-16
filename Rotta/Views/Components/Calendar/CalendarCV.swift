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
    
    var months: [Date] = []
    var currentMonthIndex = 0
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .right
        label.textColor = .rottaYellow
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
            label.font = Fonts.BodyEmphasized
            label.textColor = (index == 0 || index == 5 || index == 6) ? .rottaYellow : .systemGray
            stack.addArrangedSubview(label)
        }
        
        return stack
    }()
    
    lazy var monthsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MonthCell.self, forCellWithReuseIdentifier: "MonthCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupMonths()
        updateHeaderLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupMonths()
        updateHeaderLabel()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(headerLabel)
        addSubview(weekdayStackView)
        addSubview(monthsCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -46),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            weekdayStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            weekdayStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            weekdayStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            monthsCollectionView.topAnchor.constraint(equalTo: weekdayStackView.bottomAnchor, constant: 8),
            monthsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            monthsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            monthsCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func setupMonths() {
        months.removeAll()
        
        let startMonth = calendar.date(byAdding: .month, value: -12, to: currentDate) ?? currentDate
        
        for i in 0..<25 {
            if let month = calendar.date(byAdding: .month, value: i, to: startMonth) {
                months.append(month)
            }
        }
        
        currentMonthIndex = 12
        
        monthsCollectionView.reloadData()
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: self.currentMonthIndex, section: 0)
            self.monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func updateHeaderLabel() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "MMM"
        headerLabel.text = formatter.string(from: currentDate).capitalized
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
        
        for cell in monthsCollectionView.visibleCells {
            if let monthCell = cell as? MonthCell {
                monthCell.updateSelectedDate(selectedDate)
            }
        }
    }
    
    func goToNextMonth() {
        guard currentMonthIndex < months.count - 1 else { return }
        
        currentMonthIndex += 1
        currentDate = months[currentMonthIndex]
        
        let indexPath = IndexPath(item: currentMonthIndex, section: 0)
        monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        updateHeaderLabel()
        delegate?.didChangeMonth(currentDate)
    }
    
    func goToPreviousMonth() {
        guard currentMonthIndex > 0 else { return }
        
        currentMonthIndex -= 1
        currentDate = months[currentMonthIndex]
        
        let indexPath = IndexPath(item: currentMonthIndex, section: 0)
        monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        updateHeaderLabel()
        delegate?.didChangeMonth(currentDate)
    }
    
    func goToMonth(_ date: Date, animated: Bool = true) {
        guard let targetIndex = months.firstIndex(where: { 
            calendar.isDate($0, equalTo: date, toGranularity: .month) 
        }) else { return }
        
        currentMonthIndex = targetIndex
        currentDate = months[currentMonthIndex]
        
        let indexPath = IndexPath(item: currentMonthIndex, section: 0)
        monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        
        updateHeaderLabel()
        delegate?.didChangeMonth(currentDate)
    }
}
