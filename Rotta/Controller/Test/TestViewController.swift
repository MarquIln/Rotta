import UIKit

class TestController: UIViewController {
    
//    private lazy var headerView:GlossaryHeaderView = {
//        let header = GlossaryHeaderView()
//        header.translatesAutoresizingMaskIntoConstraints = false
//        
//        return header
//    }()
    
    private lazy var glossaryTableView: GlossaryTableView = {
        let tableView = GlossaryTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .red
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        view.backgroundColor = .backgroundPrimary
    }
}

extension TestController: ViewCodeProtocol {
    func addSubviews() {
//        view.addSubview(headerView)
        view.addSubview(glossaryTableView)
    }
    
    func setupConstraints() {        
        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            glossaryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            glossaryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            glossaryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
