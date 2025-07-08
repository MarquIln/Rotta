
import UIKit

class AllScuderiasVC: UIViewController, FormulaFilterable {
    let database = Database.shared
    private var currentFormula: FormulaType = .formula2
    
    var scuderias: [ScuderiaModel] = [ ]

    lazy var headerView: ScuderiaHeaderView = {
        let headerView = ScuderiaHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    lazy var scuderiaTableView: ScuderiaTableView = {
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
        
        setup()
        
        addGradientGlossary()
        loadScuderia()
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
        }
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
}
