
import UIKit

protocol ScuderiaTableViewDelegate: AnyObject {
    func numberOfItems() -> Int
    func item(at index: Int) -> (title: String, imageName: String)
    func didSelectItem(at index: Int)
}

class ScuderiaTableView: UIView {
    
    weak var delegate: ScuderiaTableViewDelegate?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(ScuderiaCell.self, forCellReuseIdentifier: "ScuderiaCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ScuderiaTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScuderiaCell", for: indexPath) as? ScuderiaCell,
              let item = delegate?.item(at: indexPath.row)
        else { return UITableViewCell() }
        
        cell.configure(with: item.title, imageName: item.imageName)
        cell.delegate = delegate as? ScuderiaCellDelegate
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ScuderiaTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectItem(at: indexPath.row)
    }
}

