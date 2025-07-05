//
//  CalendarDayCell.swift
//  Rotta
//
//  Created by Marcos on 11/06/25.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    private lazy var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textAlignment = .center
        dayLabel.font = .systemFont(ofSize: 16)
        dayLabel.textColor = .rottaGray
        dayLabel.translatesAutoresizingMaskIntoConstraints = false

        return dayLabel
    }()

    private lazy var decorationView: UIView = {
        let dotView = UIView()
        dotView.layer.cornerRadius = 4
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.isHidden = true

        return dotView
    }()

    func configure(with date: Date?, isSelected: Bool, isToday: Bool, hasEvent: Bool = false) {
        guard let date = date else {
            dayLabel.text = ""
            decorationView.isHidden = true
            return
        }

        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        dayLabel.text = "\(day)"
        resetToDefaultState()

        if isSelected {
            applySelectedState(hasEvent: hasEvent)
            return
        }
        
        if isToday {
            applyTodayState(hasEvent: hasEvent)
            return
        }
        
        if hasEvent {
            applyEventState()
            return
        }
    }
    
    private func resetToDefaultState() {
        dayLabel.font = .systemFont(ofSize: 16)
        dayLabel.textColor = .rottaGray
        decorationView.isHidden = true
        decorationView.backgroundColor = .clear
    }
    
    private func applySelectedState(hasEvent: Bool) {
        dayLabel.font = .boldSystemFont(ofSize: 16)
        dayLabel.textColor = .formulaPrimary // Usar cor dinâmica da fórmula
        
        if hasEvent {
            decorationView.isHidden = false
            decorationView.backgroundColor = .formulaPrimary
        }
    }
    
    private func applyTodayState(hasEvent: Bool) {
        dayLabel.font = .boldSystemFont(ofSize: 16)
        dayLabel.textColor = hasEvent ? .rottaYellow : .rottaGray
        
        if hasEvent {
            decorationView.isHidden = false
            decorationView.backgroundColor = .rottaYellow
        }
    }
    
    private func applyEventState() {
        dayLabel.font = .boldSystemFont(ofSize: 16)
        dayLabel.textColor = .rottaYellow
        decorationView.isHidden = false
        decorationView.backgroundColor = .rottaYellow
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        FormulaColorManager.shared.addDelegate(self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
}

extension CalendarDayCell: ViewCodeProtocol {
    func addSubviews() {
        contentView.addSubview(decorationView)
        contentView.addSubview(dayLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            decorationView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            decorationView.topAnchor.constraint(
                equalTo: dayLabel.bottomAnchor,
                constant: 8
            ),
            decorationView.widthAnchor.constraint(equalToConstant: 8),
            decorationView.heightAnchor.constraint(equalToConstant: 8),

            dayLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            dayLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
        ])
    }
}

extension CalendarDayCell: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.setNeedsDisplay()
        }
    }
}
