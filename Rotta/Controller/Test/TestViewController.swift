import UIKit

class TestController: UIViewController {
    
//        private lazy var scroll: GlossaryExploreCell = {
//            let scroll = GlossaryExploreCell()
//            scroll.translatesAutoresizingMaskIntoConstraints = false
//    
//            return scroll
//        }()
    
        private lazy var scuderiaTableView: ScuderiaTableView = {
            let tableView = ScuderiaTableView()
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
    //
extension TestController: ViewCodeProtocol {
    func addSubviews() {
        //        view.addSubview(headerView)
        view.addSubview(scuderiaTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            //            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            scuderiaTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scuderiaTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scuderiaTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
