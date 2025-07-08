//
//  DriverPickerActionSheet.swift
//  Rotta
//
//  Created by Marcos on 06/07/25.
//

import UIKit

class DriverPickerActionSheet {
    
    static func showDriverPicker(from viewController: UIViewController, 
                                selectedDriver: DriverModel?,
                                completion: @escaping (DriverModel?) -> Void) {
        
        let alert = UIAlertController(title: "Selecione seu piloto favorito", 
                                    message: nil, 
                                    preferredStyle: .actionSheet)
        
        // Buscar pilotos
        let driverService = DriverService()
        
        Task {
            let drivers = await driverService.getAll()
            let sortedDrivers = drivers.sorted { $0.name < $1.name }
            
            await MainActor.run {
                // Adicionar opção "Nenhum"
                let noneAction = UIAlertAction(title: "Nenhum piloto", style: .default) { _ in
                    completion(nil)
                }
                if selectedDriver == nil {
                    noneAction.setValue(true, forKey: "checked")
                }
                alert.addAction(noneAction)
                
                // Adicionar pilotos
                for driver in sortedDrivers {
                    let action = UIAlertAction(title: driver.name, style: .default) { _ in
                        completion(driver)
                    }
                    
                    // Marcar piloto selecionado
                    if selectedDriver?.name == driver.name {
                        action.setValue(true, forKey: "checked")
                    }
                    
                    alert.addAction(action)
                }
                
                // Botão cancelar
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
                
                // Configurar para iPad
                if let popover = alert.popoverPresentationController {
                    popover.sourceView = viewController.view
                    popover.sourceRect = CGRect(x: viewController.view.bounds.midX, 
                                              y: viewController.view.bounds.midY, 
                                              width: 0, height: 0)
                    popover.permittedArrowDirections = []
                }
                
                viewController.present(alert, animated: true)
            }
        }
    }
}
