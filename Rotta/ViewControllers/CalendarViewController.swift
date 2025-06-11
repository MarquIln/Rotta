import UIKit

class CalendarViewController: UIViewController {
    
    private let calendarView: UICalendarView = {
        let calendar = UICalendarView()
        calendar.calendar = .current
        calendar.locale = Locale(identifier: "pt_BR")
        calendar.fontDesign = .rounded
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.overrideUserInterfaceStyle = .dark
        
        if #available(iOS 17.0, *) {
            calendar.wantsDateDecorations = true
        }
        
        return calendar
    }()
    
   
    private let markedDays: Set<Int> = [28, 29, 30]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            calendarView.heightAnchor.constraint(equalToConstant: 450)
        ])
        
        calendarView.delegate = self
    }
}

extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
      
        guard let day = dateComponents.day, markedDays.contains(day) else {
            return nil
        }
        
        let image = UIImage(systemName: "circle.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        return .image(image)
    }
}
