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

    lazy var driverFirstPlaceView: DriverView = {
        let view = DriverView()
        return view
    }()
    
    lazy var driverSecondPlaceView: DriverView = {
        let view = DriverView()
        return view
    }()
    
    lazy var driverThirdPlaceView: DriverView = {
        let view = DriverView()
        return view
    }()
    
    lazy var driverHeaderView: UILabel = {
        let view = UILabel()
        view.text = "Pilotos"
        view.font = Fonts.Title2
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right.circle.fill"), for: .normal)
        button.tintColor = .rottaYellow
        return button
    }()
    
    lazy var seeAllScuderiasButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right.circle.fill"), for: .normal)
        button.tintColor = .rottaYellow
        return button
    }()
    
    lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [driverHeaderView, seeAllButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        driverHeaderView.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        
        return stack
    }()
    
    lazy var driverStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [driverSecondPlaceView, driverFirstPlaceView, driverThirdPlaceView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.alignment = .bottom

        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .f2Corrida
        view.layer.cornerRadius = 32

        return view
    }()
    
    lazy var mainDriverStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerStackView, driverStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .f2Corrida
        stack.spacing = 8
        stack.layer.cornerRadius = 12
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    lazy var scuderiaFirstPlaceView: ScuderiaView = {
        let view = ScuderiaView()
        return view
    }()
    
    lazy var scuderiaSecondPlaceView: ScuderiaView = {
        let view = ScuderiaView()
        return view
    }()
    
    lazy var scuderiaThirdPlaceView: ScuderiaView = {
        let view = ScuderiaView()
        return view
    }()
    
    lazy var scuderiaHeaderView: UILabel = {
        let view = UILabel()
        view.text = "Scuderias"
        view.font = Fonts.Title2
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [scuderiaHeaderView, seeAllScuderiasButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill

        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        scuderiaHeaderView.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        
        return stack
    }()
    
    lazy var scuderiaStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [scuderiaSecondPlaceView, scuderiaFirstPlaceView, scuderiaThirdPlaceView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.alignment = .bottom

        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .f2Corrida
        view.layer.cornerRadius = 32
        
        return view
    }()
    
    lazy var mainScuderiaStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerStack, scuderiaStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .f2Corrida
        stack.spacing = 8
        stack.layer.cornerRadius = 12
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [mainDriverStack, mainScuderiaStack])
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
                if drivers.count > 0 {
                    self.driverFirstPlaceView.configure(with: drivers[0], rank: 1)
                }
                if drivers.count > 1 {
                    self.driverSecondPlaceView.configure(with: drivers[1], rank: 2)
                }
                if drivers.count > 2 {
                    self.driverThirdPlaceView.configure(with: drivers[2], rank: 3)
                }
            }
        }
    }
    
    private func loadScuderias() {
        Task {
            scuderias = await database.getAllScuderias()
            
            scuderias.sort { $0.points > $1.points }
            await MainActor.run {
                if scuderias.count > 0 {
                    self.scuderiaFirstPlaceView.configure(with: scuderias[0], rank: 1)
                }
                if scuderias.count > 1 {
                    self.scuderiaSecondPlaceView.configure(with: scuderias[1], rank: 2)
                }
                if scuderias.count > 2 {
                    self.scuderiaThirdPlaceView.configure(with: scuderias[2], rank: 3)
                }
            }
        }
    }
}
