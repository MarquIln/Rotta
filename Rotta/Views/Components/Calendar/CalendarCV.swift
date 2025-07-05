//
//  CalendarCV.swift
//  Rotta
//
//  Created by Marcos on 11/06/25.
//

import UIKit

protocol CalendarCollectionViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
    func didChangeMonth(_ month: Date)
}

class CalendarCollectionView: UIView {
    weak var delegate: CalendarCollectionViewDelegate?
    
    var currentDate = Date()
    var selectedDate: Date?
    var currentFormula: FormulaType = .formula2
    let calendar = Calendar.current
    
    var months: [Date] = []
    var currentMonthIndex = 0
    
    private let eventService = EventService()
    private var eventsCache: [Date: [EventModel]] = [:]
    private var loadedMonths: Set<String> = []
    
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
        selectTodayByDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupMonths()
        updateHeaderLabel()
        selectTodayByDefault()
    }
    
    private func selectTodayByDefault() {
        let today = Date()
        selectedDate = today
        
        if currentFormula == .formula2 && UserPreferencesManager.shared.hasSelectedFormula() {
            currentFormula = UserPreferencesManager.shared.getSelectedFormula()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateSelectedDateOnVisibleCells()
        }
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
            
            self.updateSelectedDateOnVisibleCells()
        }
    }
    
    private func updateSelectedDateOnVisibleCells() {
        for cell in monthsCollectionView.visibleCells {
            if let monthCell = cell as? MonthCell {
                monthCell.updateSelectedDate(selectedDate)
                monthCell.daysCollectionView.reloadData()
            }
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
        updateSelectedDateOnVisibleCells()
    }
    
    func updateEvents(_ events: [EventModel]) {
        Task {
            await updateEventsCache(with: events)
        }
    }
    
    func updateEvents(_ events: [EventModel], for formula: FormulaType) {
        currentFormula = formula
        Task {
            await updateEventsCache(with: events)
        }
    }
    
    @MainActor
    private func updateEventsCache(with events: [EventModel]) async {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        eventsCache.removeAll()
        
        for event in events {
            guard let eventDate = event.date else { continue }
            let dayKey = calendar.startOfDay(for: eventDate)
            
            if eventsCache[dayKey] == nil {
                eventsCache[dayKey] = []
            }
            eventsCache[dayKey]?.append(event)
        }
        
        monthsCollectionView.reloadData()
        
        updateSelectedDateOnVisibleCells()
    }
    
    func preloadAllEvents() {
        Task {
            await loadAllEventsAtOnce()
        }
    }
    
    @MainActor
    private func loadAllEventsAtOnce() async {
        let allEvents = await eventService.getEvents(for: currentFormula)
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        eventsCache.removeAll()
        
        for event in allEvents {
            guard let eventDate = event.date else { continue }
            let dayKey = calendar.startOfDay(for: eventDate)
            
            if eventsCache[dayKey] == nil {
                eventsCache[dayKey] = []
            }
            eventsCache[dayKey]?.append(event)
        }
        
        let startYear = 2024
        let endYear = 2030
        for year in startYear...endYear {
            for month in 1...12 {
                let monthKey = String(format: "%04d-%02d", year, month)
                loadedMonths.insert(monthKey)
            }
        }
        
        monthsCollectionView.reloadData()
        updateSelectedDateOnVisibleCells()
    }
    
    func loadEventsForVisibleDates() {
        guard !isUserInteracting else { return }
        
        Task {
            await loadEventsForCurrentMonth()
        }
    }
    
    var isUserInteracting: Bool = false
    
    @MainActor
    private func loadEventsForCurrentMonth() async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let monthKey = formatter.string(from: currentDate)
        
        guard !loadedMonths.contains(monthKey) else {
            monthsCollectionView.reloadData()
            updateSelectedDateOnVisibleCells()
            return
        }
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let startOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let endOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.end ?? currentDate
        
        let allEventsForFormula = await eventService.getEvents(for: currentFormula)
        let allEvents = allEventsForFormula.filter { event in
            guard let eventDate = event.date else { return false }
            return eventDate >= startOfMonth && eventDate < endOfMonth
        }
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 30
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                let dayKey = calendar.startOfDay(for: date)
                eventsCache[dayKey] = []
            }
        }
        
        for event in allEvents {
            guard let eventDate = event.date else { continue }
            let dayKey = calendar.startOfDay(for: eventDate)
            
            if eventsCache[dayKey] == nil {
                eventsCache[dayKey] = []
            }
            eventsCache[dayKey]?.append(event)
        }

        loadedMonths.insert(monthKey)
        
        monthsCollectionView.reloadData()
        updateSelectedDateOnVisibleCells()
    }
    
    func hasEvent(for date: Date) -> Bool {
        var calendarForCheck = Calendar.current
        calendarForCheck.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let dayKey = calendarForCheck.startOfDay(for: date)
        return !(eventsCache[dayKey]?.isEmpty ?? true)
    }
    
    func goToNextMonth() {
        guard currentMonthIndex < months.count - 1 else { return }
        
        currentMonthIndex += 1
        currentDate = months[currentMonthIndex]
        
        let indexPath = IndexPath(item: currentMonthIndex, section: 0)
        monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        updateHeaderLabel()
        delegate?.didChangeMonth(currentDate)
        
        loadEventsForVisibleDates()
    }
    
    func goToPreviousMonth() {
        guard currentMonthIndex > 0 else { return }
        
        currentMonthIndex -= 1
        currentDate = months[currentMonthIndex]
        
        let indexPath = IndexPath(item: currentMonthIndex, section: 0)
        monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        updateHeaderLabel()
        delegate?.didChangeMonth(currentDate)
        
        loadEventsForVisibleDates()
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
    
    func selectTodayManually() {
        let today = Date()
        selectedDate = today
        
        if let todayIndex = months.firstIndex(where: { calendar.isDate($0, equalTo: today, toGranularity: .month) }) {
            currentMonthIndex = todayIndex
            currentDate = months[currentMonthIndex]
            
            let indexPath = IndexPath(item: currentMonthIndex, section: 0)
            monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        monthsCollectionView.reloadData()
        updateSelectedDateOnVisibleCells()
    }
    
    func clearCacheAndReload() {
        eventsCache.removeAll()
        loadedMonths.removeAll()
        monthsCollectionView.reloadData()
        loadEventsForVisibleDates()
    }
}
