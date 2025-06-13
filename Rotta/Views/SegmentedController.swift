import UIKit

class SegmentedControll: UIView {
    var items: [String]
    var selectedIndex: Int = 0 {
        didSet {
            updateIndicator(animated: true)
        }
    }

    private var indicatorCenterX: NSLayoutConstraint!
    var didSelectSegment: ((Int) -> Void)?

    lazy var buttons: [UIButton] = {
        var array = [UIButton]()
        for (i, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.tag = i
            button.setTitle(title, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
            array.append(button)
        }
        return array
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .yellowPrimary
        return view
    }()

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        configureSegments()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSegments() {
        for btn in buttons {
            stackView.addArrangedSubview(btn)
        }
    }

    func updateIndicator(animated: Bool) {
        layoutIfNeeded()
        let segmentWidth = bounds.width / CGFloat(items.count)
        indicatorCenterX.constant = segmentWidth * (CGFloat(selectedIndex) + 0.5)

        let animBlock = {
            self.layoutIfNeeded()
        }

        if animated {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: animBlock,
                completion: nil
            )
        } else {
            animBlock()
        }

        for (i, btn) in buttons.enumerated() {
            btn.setTitleColor(i == selectedIndex ? .black : .gray, for: .normal)
            btn.titleLabel?.font = i == selectedIndex ? Fonts.FootnoteEmphasized : Fonts.FootnoteRegular
            btn.backgroundColor = .clear
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
        updateIndicator(animated: false)
    }


    @objc private func tap(_ btn: UIButton) {
        let idx = btn.tag
        guard idx != selectedIndex else { return }
        selectedIndex = idx
        updateIndicator(animated: true)
        didSelectSegment?(idx)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let idx = gesture.view?.tag, idx != selectedIndex else { return }
        selectedIndex = idx
    }
}

extension SegmentedControll: ViewCodeProtocol {
    func setup() {
        self.backgroundColor = .fillsUnselected
        self.layer.cornerRadius = 16
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(indicatorView)
        addSubview(stackView)
    }

    func setupConstraints() {
        let segmentWidthMultiplier = 1.0 / CGFloat(items.count)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            indicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: segmentWidthMultiplier, constant: -12),
//            indicatorView.heightAnchor.constraint(equalToConstant: 28),
            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])

        indicatorCenterX = indicatorView.centerXAnchor.constraint(equalTo: leadingAnchor)
        indicatorCenterX.isActive = true
    }
}
