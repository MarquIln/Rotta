
import UIKit

class ScuderiaTableViewController: UIViewController, FormulaFilterable {
    
    
    private let service = ScuderiaService()
    let database = Database.shared
    private var currentFormula: FormulaType = .formula2
    
    private var scuderias: [ScuderiaModel] = [ ]

    private lazy var headerView: ScuderiaHeaderView = {
        let headerView = ScuderiaHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private lazy var scuderiaTableView: ScuderiaTableView = {
        let tableView = ScuderiaTableView()
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

    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentFormula = Database.shared.getSelectedFormula()
        
        setupView()
        
        addGradientGlossary()
        loadScuderia()
        FormulaColorManager.shared.addDelegate(self)
    }
    
    deinit {
        FormulaColorManager.shared.removeDelegate(self)
    }
    
    private func loadScuderia() {
        Task {
            scuderias = await database.getScuderias(for: currentFormula)
            
            await MainActor.run {
                self.scuderiaTableView.reloadData()
            }
        }
    }
    
    func updateData(for formula: FormulaType) {
        currentFormula = formula
        loadScuderia()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    @objc private func customBackTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Scuderias"
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(gradientView)
        view.addSubview(headerView)
        view.addSubview(scuderiaTableView)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            scuderiaTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            scuderiaTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scuderiaTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scuderiaTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scuderiaTableView.reloadData()
    }
}
extension ScuderiaTableViewController: ScuderiaTableViewDelegate {
    func numberOfItems() -> Int {
        scuderias.count
    }
    
    func item(at index: Int) -> (title: String, imageName: String) {
        return (scuderias[index].name, scuderias[index].logo)
    }
    
    func didSelectItem(at index: Int) {
        let detailsVC = ScuderiaDetailsViewController()
            detailsVC.scuderia = scuderias[index]
          detailsVC.component.configure(with: scuderias[index])
            navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ScuderiaTableViewController: FormulaColorManagerDelegate {
    func formulaColorsDidChange() {
        DispatchQueue.main.async {
            self.addGradientGlossary()
        }
    }
}

