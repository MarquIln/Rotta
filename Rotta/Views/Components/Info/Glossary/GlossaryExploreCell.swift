import UIKit

class GlossaryExploreCell: UIView {
    
    var glossaryTerms: [GlossaryModel] = [] {
        didSet {
            updateContent()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore nosso glossário"
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var leftChevron: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.left"))
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rightChevron: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.backgroundColor = .fillsTextbox
        self.layer.cornerRadius = 32
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func configure(with terms: [GlossaryModel]) {
        self.glossaryTerms = terms
        updateContent()
    }
    
    private func updateContent() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let termsToDisplay = glossaryTerms.isEmpty ? createDefaultTerms() : Array(glossaryTerms.prefix(10))
        
        let items = termsToDisplay.map { term in
            createCircleItem(title: term.title ?? "Termo", imageName: term.image)
        }
        
        for i in stride(from: 0, to: items.count, by: 2) {
            let pageContainer = UIView()
            pageContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let pageStack = UIStackView()
            pageStack.axis = .horizontal
            pageStack.spacing = 24
            pageStack.distribution = .fillEqually
            pageStack.translatesAutoresizingMaskIntoConstraints = false
            
            let endIndex = min(i+2, items.count)
            for j in i..<endIndex {
                pageStack.addArrangedSubview(items[j])
            }
            
            pageContainer.addSubview(pageStack)
            stackView.addArrangedSubview(pageContainer)
            
            NSLayoutConstraint.activate([
                pageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                pageStack.centerXAnchor.constraint(equalTo: pageContainer.centerXAnchor),
                pageStack.centerYAnchor.constraint(equalTo: pageContainer.centerYAnchor),
                pageStack.leadingAnchor.constraint(greaterThanOrEqualTo: pageContainer.leadingAnchor, constant: 30),
                pageStack.trailingAnchor.constraint(lessThanOrEqualTo: pageContainer.trailingAnchor, constant: -30)
            ])
        }
    }
    
    private func createDefaultTerms() -> [GlossaryModel] {
        return (1...10).map { i in
            GlossaryModel(title: "Termo \(i)", image: "glossary_default")
        }
    }
    
    private func createCircleItem(title: String, imageName: String? = nil) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 8
        
        let circle = UIView()
        circle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        circle.layer.cornerRadius = 30
        circle.clipsToBounds = true
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            circle.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: circle.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: circle.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: circle.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: circle.bottomAnchor)
            ])
        } else {
            let colors: [UIColor] = [.systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemRed, .systemTeal]
            circle.backgroundColor = colors.randomElement() ?? .systemBlue
        }
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        container.addArrangedSubview(circle)
        container.addArrangedSubview(label)
        return container
    }
}

extension GlossaryExploreCell: ViewCodeProtocol {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(leftChevron)
        addSubview(rightChevron)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 361).isActive = true
        self.heightAnchor.constraint(equalToConstant: 156).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            leftChevron.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            leftChevron.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            rightChevron.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            rightChevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}
