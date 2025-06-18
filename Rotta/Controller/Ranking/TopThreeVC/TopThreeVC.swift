//
//  RankingViewController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 13/06/25.
//

import UIKit

class TopThreeVC: UIViewController {
    var drivers: [DriverModel] = []
    var scuderias: [ScuderiaModel] = []
    
    let database = Database.shared

    lazy var driversView: TopThreeDriversView = {
        let view = TopThreeDriversView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.layer.cornerRadius = 32

        return view
    }()
    
    lazy var scuderiasView: TopThreeScuderiasView = {
        let view = TopThreeScuderiasView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [driversView, scuderiasView])
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handleTap() {
        let vc = RankingVC()
        navigationController?.pushViewController(vc, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loadDrivers()
        loadScuderias()
        setup()
    }

    private func loadDrivers() {
        Task {
            drivers = await database.getAllDrivers()

            drivers.sort { $0.points > $1.points }
            await MainActor.run {
                self.driversView.configure(with: drivers)
            }
        }
    }
    
    private func loadScuderias() {
        Task {
            scuderias = await database.getAllScuderias()
            
            scuderias.sort { $0.points > $1.points }
            await MainActor.run {
                self.scuderiasView.configure(with: scuderias)
            }
        }
    }
}
