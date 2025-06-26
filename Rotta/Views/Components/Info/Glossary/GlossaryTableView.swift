//
//  GlossaryTableView.swift
//  Rotta
//
//  Created by sofia leitao on 16/06/25.
//

import UIKit

protocol GlossaryTableViewDelegate: AnyObject {
    func numberOfItems() -> Int
    func item(at index: Int) -> (title: String, imageName: String)
    func didSelectItem(at index: Int)
}

class GlossaryTableView: UIView {
    weak var delegate: GlossaryTableViewDelegate?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(GlossaryCell.self, forCellReuseIdentifier: "GlossaryCell")
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
extension GlossaryTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GlossaryCell", for: indexPath) as? GlossaryCell,
              let item = delegate?.item(at: indexPath.row) else {
            return UITableViewCell()
        }

        cell.configure(with: item.title)
        cell.delegate = delegate as? GlossaryCellDelegate
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GlossaryTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectItem(at: indexPath.row)
    }
}
