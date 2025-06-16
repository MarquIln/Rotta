//
//  Untitled.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//
import UIKit
class MainTabController: UIViewController {
    let segmented = SegmentedControll(items: ["Calendário", "Ranking", "Infos"])

    let viewControllers: [UIViewController] = [
        CalendarViewController(),
        RankingVC(),
        InfosViewController()
    ]

    var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary

        setupSegmented()
        displayViewController(at: 0)
    }

    private func setupSegmented() {
        view.addSubview(segmented)
        segmented.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmented.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmented.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmented.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmented.heightAnchor.constraint(equalToConstant: 32)
        ])

        segmented.didSelectSegment = { [weak self] index in
            self?.displayViewController(at: index)
        }
    }

    private func displayViewController(at index: Int) {
        currentVC?.removeFromParent()
        currentVC?.view.removeFromSuperview()

        let selectedVC = viewControllers[index]
        addChild(selectedVC)
        view.addSubview(selectedVC.view)

        selectedVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedVC.view.topAnchor.constraint(equalTo: segmented.bottomAnchor, constant: 8),
            selectedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectedVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        selectedVC.didMove(toParent: self)
        currentVC = selectedVC
    }
}
