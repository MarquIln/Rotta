//
//  segmentedController.swift
//  Rotta
//
//  Created by Isadora Ferreira Guerra on 10/06/25.
//
import UIKit

class SegmentedControll: UIView {
    var items: [String]
    var selectedIndex: Int = 0 {
        didSet {
            //            updateIndicator(animated: true)
        }
    }
    private var indicatorLeading: NSLayoutConstraint!
    var didSelectSegment: ((Int) -> Void)?

    lazy var buttons: [UIButton] = {
        var array = [UIButton]()
        for (i, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.tag = i
            button.setTitle(title, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
            array.append(button)
        }
        return array
    }()

    lazy var configureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()

    //visualizacao do selecionado
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .blue
        return view
    }()

    private lazy var stackView = UIStackView()
    private lazy var labels = [UILabel]()

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        configureSegments()
        setup()
        updateIndicator(animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateIndicator(animated: Bool) {
        layoutIfNeeded()
        let segmentWidth = bounds.width / CGFloat(items.count)
        let newLeading =
            segmentWidth * CGFloat(selectedIndex) + (segmentWidth - 10) / 2
        indicatorLeading.constant = newLeading

        let animBlock = { self.layoutIfNeeded() }

        if animated {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.8,
                options: [.curveEaseInOut],
                animations: animBlock,
                completion: nil
            )
        } else {
            animBlock()
        }

        for (i, btn) in buttons.enumerated() {
            btn.setTitleColor(i == selectedIndex ? .black : .gray, for: .normal)
            btn.titleLabel?.font = .systemFont(
                ofSize: 14,
                weight: i == selectedIndex ? .semibold : .regular
            )
        }
    }

    private func configureSegments() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for btn in buttons {
            stackView.addArrangedSubview(btn)
        }
    }

    @objc private func tap(_ btn: UIButton) {
        let idx = btn.tag
        guard idx != selectedIndex else { return }
        selectedIndex = idx
        updateIndicator(animated: true)
        didSelectSegment?(idx)  // aqui você conta ao VC que trocou
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let idx = gesture.view?.tag, idx != selectedIndex else { return }
        selectedIndex = idx
    }
}

extension SegmentedControll: ViewCodeProtocol {
    func setup() {
        self.backgroundColor = .fillsUnselected
        self.layer.cornerRadius = 20
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(indicatorView)
        addSubview(stackView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 2),
            indicatorView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -2),
        ])

        // Indicator constraints
        let widthConstraint = indicatorView.widthAnchor.constraint(
            equalTo: widthAnchor,
            multiplier: 1.0 / CGFloat(items.count),
            constant: -16
        )
        let heightConstraint = indicatorView.heightAnchor.constraint(
            equalToConstant: 4
        )
        indicatorLeading = indicatorView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 8
        )

        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint,
            indicatorLeading,
            indicatorView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -2
            ),
        ])
    }
}
