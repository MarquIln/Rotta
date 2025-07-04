//
//  ScuderiaDetailsViewController.swift
//  Rotta
//
//  Created by sofia leitao on 21/06/25.
//
//
import UIKit

class ScuderiaDetailsViewController: UIViewController {
    
    var scuderia: ScuderiaModel? {
        didSet {
            print("Scuderia configurada: \(scuderia?.name ?? "nil")")
            if let scuderia = scuderia {
                component.configure(with: scuderia)
            }
        }
    }
    
    lazy var component: ScuderiaDetails = {
        let component = ScuderiaDetails()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
        
//        lazy var component: ScuderiaDetails = {
//            let component = ScuderiaDetails()
//            component.translatesAutoresizingMaskIntoConstraints = false
//            return component
//        }()
        
        lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.showsVerticalScrollIndicator = false
            return scroll
        }()
        
        lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var gradientView: UIView = {
            let gradient = UIView()
            gradient.translatesAutoresizingMaskIntoConstraints = false
            gradient.isUserInteractionEnabled = false
            return gradient
        }()
        
        lazy var imageBackground: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "f3")
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
    @objc func addGradientGlossary() {
        DispatchQueue.main.async {
            self.gradientView.addGradientGlossary()
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            setupNavigationBar()
            setupGestures()
            setup()
            addGradientGlossary()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
            
            if let scuderia = scuderia {
                component.configure(with: scuderia)
            }
        }
        
        private func setupGestures() {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            
            let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
            swipeRightGesture.direction = .right
            view.addGestureRecognizer(swipeRightGesture)
        }
        
        @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
            if gesture.direction == .right {
                navigationController?.popViewController(animated: true)
            }
        }
        
        @objc private func handleEdgePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
            let translation = gesture.translation(in: view)
            let velocity = gesture.velocity(in: view)
            
            switch gesture.state {
            case .ended:
                if translation.x > 100 || velocity.x > 500 {
                    navigationController?.popViewController(animated: true)
                }
            default:
                break
            }
        }
        
        @objc private func customBackTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        private func setupCustomBackButton() {
            navigationItem.hidesBackButton = true
        
            let backButton = UIButton(type: .system)
            backButton.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
            backButton.tintColor = .rottaYellow
            backButton.backgroundColor = .clear
            backButton.layer.cornerRadius = 16
            backButton.clipsToBounds = true
            backButton.addTarget(self, action: #selector(customBackTapped), for: .touchUpInside)
            
            backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            
            let barButton = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = barButton
        }
        
        private func setupNavigationBar() {
            title = "Detalhes da Scuderia"
            setupCustomBackButton()
        }
    }

    extension ScuderiaDetailsViewController: ViewCodeProtocol {
        func addSubviews() {
            view.addSubview(imageBackground)
            view.addSubview(gradientView)
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubview(component)
        }
        
        func setupConstraints() {
            NSLayoutConstraint.activate([
                imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
                imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageBackground.heightAnchor.constraint(equalToConstant: 362),
            
                scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 212),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

                gradientView.topAnchor.constraint(equalTo: view.topAnchor),
                gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                component.topAnchor.constraint(equalTo: contentView.topAnchor),
                component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }
    }

    extension ScuderiaDetailsViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }

