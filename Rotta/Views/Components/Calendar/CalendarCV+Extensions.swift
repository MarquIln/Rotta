//
//  CalendarCV+Extensions.swift
//  Rotta
//
//  Created by Marcos on 11/06/25.
//

import UIKit

extension CalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath) as! MonthCell
        
        let month = months[indexPath.item]
        cell.configure(with: month, selectedDate: selectedDate, delegate: self)
        
        return cell
    }
}

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension CalendarCollectionView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        if currentPage != currentMonthIndex && currentPage < months.count {
            currentMonthIndex = currentPage
            currentDate = months[currentMonthIndex]
            updateHeaderLabel()
            delegate?.didChangeMonth(currentDate)
        }
    }
}

extension CalendarCollectionView: MonthCellDelegate {
    func didSelectDate(_ date: Date) {
        selectedDate = date
        delegate?.didSelectDate(date)
        
        for cell in monthsCollectionView.visibleCells {
            if let monthCell = cell as? MonthCell {
                monthCell.updateSelectedDate(selectedDate)
            }
        }
    }
}
