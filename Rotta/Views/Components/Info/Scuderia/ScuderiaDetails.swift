import UIKit

class ScuderiaDetails: UIView {
   
//    var logo: String = ""
//    var country: String = "BR"
//    var wins: String = "11"
//    var poles: Int = 11
//    var podiums: Int = 11
//    var points: Int = 11
//    var infos: String = "Resumo geralkljhgbvn m,k.jhgfdxvcfbnkl;oiuytredsfcvbhjkliuytrfdfgvbnjkuygtrfedswadfghjkn,mbv cxfdretyuioklbmnhgvfdsxcvbnm,kliouytrdtfyuiolkjhgvbnmklkijuhygtrfdesxdcfvghjl;kjfcld;skfjcldsjfcldjcflm,k.jhgfdxvcfbnkl;oiuytredsfcvbhjkliuytrfdfgvbnjkuygtrfedswadfghjkn,mbv cxfdretyuioklbmnhgvfdsxcvbnm,k.jhgfdxvcfbnkl;oiuytredsfcvbhjkliuytrfdfgvbnjkuygtrfedswadfghjkn,mbv cxfdretyuioklbmnhgvfdsxcvbn"
    
    var scuderia: ScuderiaModel? = nil
 
    lazy var scuderiaNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome da scuderia"
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scuderiaLogo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
      //  imageView.image = UIImage(named: "aix_logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    
    lazy var countryTitle: UILabel = {
        let label = UILabel()
        label.text = "País"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = scuderia?.country
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var countryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryTitle, countryLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    lazy var winTitle: UILabel = {
        let label = UILabel()
        label.text = "Vitórias"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var winLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var winStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [winTitle, winLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    lazy var divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rottaGray
        return view
    }()
    
    lazy var countryWinsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .fillsTextbox
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var countryWinsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryStack, divider1, winStack])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Componente Poles/Pódios/Pontos
    lazy var poleTitle: UILabel = {
        let label = UILabel()
        label.text = "Poles"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var poleLabel: UILabel = {
        let label = UILabel()
     //   label.text = scuderia?.pole
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var poleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [poleTitle, poleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    lazy var podiumTitle: UILabel = {
        let label = UILabel()
        label.text = "Pódios"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var podiumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var podiumStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [podiumTitle, podiumLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    lazy var pointsTitle: UILabel = {
        let label = UILabel()
        label.text = "Pontos"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelsPrimary
        label.font = Fonts.Title1
        return label
    }()
    
    lazy var pointsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pointsTitle, pointsLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 12, left: 0, bottom: 12, right: 0)
        return stack
    }()
    
    lazy var divider2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rottaGray
        return view
    }()
    
    lazy var divider3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rottaGray
        return view
    }()
    
    lazy var statsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .fillsTextbox
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var statsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [poleStack, divider2, podiumStack, divider3, pointsStack])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Componente de Resumo
    lazy var summaryView: UIView = {
        let view = UIView()
        view.backgroundColor = .fillsTextbox
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Resumo Geral"
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var summaryTextLabel: UILabel = {
        let label = UILabel()
     //   label.text = infos
        label.textColor = .labelsPrimary
        label.font = Fonts.Subtitle1
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var summaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [summaryTitleLabel, summaryTextLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScuderiaDetails: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(scuderiaLogo)
        addSubview(scuderiaNameLabel)
        addSubview(countryWinsContainer)
        countryWinsContainer.addSubview(countryWinsStack)
        addSubview(statsContainer)
        statsContainer.addSubview(statsStack)
        addSubview(summaryView)
        summaryView.addSubview(summaryStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scuderiaLogo.topAnchor.constraint(equalTo: topAnchor),
            scuderiaLogo.leadingAnchor.constraint(equalTo: leadingAnchor),
            scuderiaLogo.trailingAnchor.constraint(equalTo: trailingAnchor),
            scuderiaLogo.heightAnchor.constraint(equalToConstant: 30),
            
            scuderiaNameLabel.topAnchor.constraint(equalTo: scuderiaLogo.bottomAnchor, constant: 12),
            scuderiaNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scuderiaNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    
           
            countryWinsContainer.topAnchor.constraint(equalTo: scuderiaNameLabel.bottomAnchor, constant: 16),
            countryWinsContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryWinsContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
           
            countryWinsStack.topAnchor.constraint(equalTo: countryWinsContainer.topAnchor, constant: 16),
            countryWinsStack.leadingAnchor.constraint(equalTo: countryWinsContainer.leadingAnchor, constant: 16),
            countryWinsStack.trailingAnchor.constraint(equalTo: countryWinsContainer.trailingAnchor, constant: -16),
            countryWinsStack.bottomAnchor.constraint(equalTo: countryWinsContainer.bottomAnchor, constant: -16),
            
            
            divider1.widthAnchor.constraint(equalToConstant: 1),
            divider1.heightAnchor.constraint(equalTo: countryWinsStack.heightAnchor),
            
         
            countryStack.widthAnchor.constraint(equalTo: winStack.widthAnchor),
            winStack.widthAnchor.constraint(equalTo: countryStack.widthAnchor),
            
           
            countryLabel.widthAnchor.constraint(equalToConstant: 34),
            countryLabel.heightAnchor.constraint(equalToConstant: 41),
            
           
            statsContainer.topAnchor.constraint(equalTo: countryWinsContainer.bottomAnchor, constant: 16),
            statsContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            statsContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            statsStack.topAnchor.constraint(equalTo: statsContainer.topAnchor, constant: 16),
            statsStack.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
            statsStack.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -16),
            statsStack.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: -16),
            
            
            divider2.widthAnchor.constraint(equalToConstant: 1),
            divider2.heightAnchor.constraint(equalTo: statsStack.heightAnchor),
            
            divider3.widthAnchor.constraint(equalToConstant: 1),
            divider3.heightAnchor.constraint(equalTo: statsStack.heightAnchor),
            
          
            poleStack.widthAnchor.constraint(equalTo: podiumStack.widthAnchor),
            podiumStack.widthAnchor.constraint(equalTo: pointsStack.widthAnchor),
            pointsStack.widthAnchor.constraint(equalTo: poleStack.widthAnchor),
            
            
            summaryView.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 16),
            summaryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            summaryStack.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16),
            summaryStack.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            summaryStack.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            summaryStack.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -16)
        ])
    }
}

extension ScuderiaDetails {
    func configure(with model: ScuderiaModel) {
        print("Configurando ScuderiaDetails com: \(model.name)")
        scuderiaNameLabel.text = model.name
        scuderiaLogo.image = UIImage(named: model.logo)
        countryLabel.text = model.country.getCountryFlag()
        winLabel.text = "\(model.victory)"
        poleLabel.text = "\(model.pole)"
        podiumLabel.text = "\(model.podium)"
        pointsLabel.text = "\(model.historicPoints)"
        summaryTextLabel.text = model.details
    }
    
}
        
 
