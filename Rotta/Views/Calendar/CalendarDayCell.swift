//
//  CalendarDayCell.swift
//  Rotta
//
//  Created by Marcos on 11/06/25.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    private let dayLabel = UILabel()
    private let decorationView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        dayLabel.textAlignment = .center
        dayLabel.font = .systemFont(ofSize: 16)
        dayLabel.textColor = .labelGray
        dayLabel.translatesAutoresizingMaskIntoConstraints = false

        decorationView.layer.cornerRadius = 4
        decorationView.translatesAutoresizingMaskIntoConstraints = false
        decorationView.isHidden = true

        contentView.addSubview(decorationView)
        contentView.addSubview(dayLabel)

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

    func configure(with date: Date?, isSelected: Bool, isToday: Bool) {
        if let date = date {
            dayLabel.text = "\(Calendar.current.component(.day, from: date))"

            let day = Calendar.current.component(.day, from: date)
            
            let isMarkedDay = [7, 9, 11].contains(day) // TODO: TEM QUE MUDAR ISSO AQUI

            if isMarkedDay {
                dayLabel.textColor = .labelPrimary
                decorationView.isHidden = false
                decorationView.backgroundColor = .labelPrimary
            } else {
                dayLabel.textColor = .labelGray
                decorationView.isHidden = true
            }
        } else {
            dayLabel.text = ""
            decorationView.isHidden = true
        }
    }
}
