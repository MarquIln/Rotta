//
//  SceneDelegate.swift
//  Rotta
//
//  Created by Marcos on 10/06/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        setupRootViewController()
    }
    
    private func setupRootViewController() {
        let splashVC = SplashScreenVC()
        
        splashVC.onFinish = { [weak self] in
            self?.showMainInterface()
        }
        
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }
    
    private func showMainInterface() {
        if UserService.shared.getLoggedUser() != nil {
            showMainTabController()
        } else {
            showLoginScreen()
        }
    }
    
    private func showMainTabController() {
        let mainTabController = MainTabController()
        let navigationController = UINavigationController(rootViewController: mainTabController)
        
        window?.rootViewController = navigationController

        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
    
    private func showLoginScreen() {
        let loginVC = LoginVC()
        
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        window?.rootViewController = navigationController
        
        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
    
    func changeRootViewController(to viewController: UIViewController, animated: Bool = true) {
        guard let window = window else { return }
        
        if animated {
            UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            })
        } else {
            window.rootViewController = viewController
        }

        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

