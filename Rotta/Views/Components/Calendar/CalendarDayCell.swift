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

        if isSelected && hasEvent {
            dayLabel.font = .boldSystemFont(ofSize: 16)
            dayLabel.textColor = .f2Sprint
            decorationView.isHidden = false
            decorationView.backgroundColor = .f2Sprint
        } else if hasEvent {
            dayLabel.textColor = .rottaYellow
            dayLabel.font = .boldSystemFont(ofSize: 16)
            decorationView.isHidden = false
            decorationView.backgroundColor = .rottaYellow
        } else {
            dayLabel.textColor = .rottaGray
            decorationView.isHidden = true
        }

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder): has not been implemented")
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
