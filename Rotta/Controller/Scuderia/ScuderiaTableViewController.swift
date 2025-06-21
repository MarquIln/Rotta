import UIKit

class ScuderiaTableViewController: UIViewController {

    private lazy var headerView: GlossaryHeaderView = {
        let headerView = GlossaryHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private lazy var scuderiaTableView: ScuderiaTableView = {
        let tableView = ScuderiaTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        setupView()
        addGradientGlossary()
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
    }
}
extension ScuderiaTableViewController: UITableViewDelegate, UITableViewDataSource, ScuderiaCellDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ScuderiaCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ScuderiaCell ?? ScuderiaCell(style: .default, reuseIdentifier: identifier)
        cell.configure(title: "Equipe \(indexPath.row + 1)")
        cell.delegate = self
        return cell
    }

    func didTapChevron(in cell: ScuderiaCell) {
        print("Chevron da célula tocado")
        let vc = ScuderiaDetailsViewController() 
        navigationController?.pushViewController(vc, animated: true)
    }
}




