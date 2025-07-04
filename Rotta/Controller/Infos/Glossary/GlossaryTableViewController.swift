//
//  GlossaryTableViewController.swift
//  Rotta
//
//  Created by sofia leitao on 16/06/25.
//
import UIKit

class GlossaryTableViewController: UIViewController {

    private let service = GlossaryService()
    let database = Database.shared
    
    private var terms: [GlossaryModel] = []
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private var lastScrollPosition: CGFloat = 0
    private let scrollThreshold: CGFloat = 30.0

    private lazy var headerView: GlossaryHeaderView = {
        let headerView = GlossaryHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        return headerView
    }()

    private lazy var glossaryTableView: GlossaryTableView = {
        let tableView = GlossaryTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()

    lazy var gradientView: UIView = {
        let gradient = UIView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        return gradient
    }()

    private let totalCells = 10

    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        impactFeedback.prepare()
        addGradientGlossary()
        loadGlossary()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func loadGlossary() {
        Task {
            terms = await database.getAllGlossaryTerms()
            
            await MainActor.run {
                self.glossaryTableView.reloadData()
            }
        }
    }
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(
            UIImage(systemName: "chevron.left.circle.fill"),
            for: .normal
        )
        backButton.tintColor = .rottaYellow
        backButton.backgroundColor = .clear
        backButton.layer.cornerRadius = 16
        backButton.clipsToBounds = true
        backButton.addTarget(
            self,
            action: #selector(customBackTapped),
            for: .touchUpInside
        )

        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        return backButton
    }()

    @objc private func customBackTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Glossário"
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(gradientView)
        view.addSubview(headerView)
        view.addSubview(glossaryTableView)

        NSLayoutConstraint.activate([

            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            headerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 118
            ),
            headerView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            headerView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),

            glossaryTableView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 20
            ),
            glossaryTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            glossaryTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            glossaryTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])

        glossaryTableView.reloadData()
    }
}

extension GlossaryTableViewController: GlossaryTableViewDelegate {
    func numberOfItems() -> Int {
        return terms.count
    }

    func item(at index: Int) -> (title: String, imageName: String) {
        return (terms[index].title ?? "no title", "carro")
    }

    func didSelectItem(at index: Int) {
        let glossaryVC = GlossaryDetailsViewController()
        glossaryVC.term = terms[index]
        glossaryVC.allTerms = terms
        navigationController?.pushViewController(glossaryVC, animated: true)
    }
}
