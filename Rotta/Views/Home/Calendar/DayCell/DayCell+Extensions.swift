//
//  DayCell+Extensions.swift
//  Rotta
//
//  Created by Marcos on 08/07/25.
//

import UIKit

extension DayCell: ViewCodeProtocol {
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
            )
        ])
    }
}

extension DayCell: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.setNeedsDisplay()
        }
    }
}

