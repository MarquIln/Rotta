//
//  SplashScreenVC.swift
//  Rotta
//
//  Created by Marcos on 18/06/25.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {
    var onFinish: (() -> Void)?
    
    private var animationView: LottieAnimationView?
    private let animationNames = ["Rotta"]
    private var currentIndex = 0

    private var isSeedComplete: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        startSeedCheckInBackground()
        playNextAnimation()
    }

    private func startSeedCheckInBackground() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let result = CloudKitSeed.isSeedCompleted()
            DispatchQueue.main.async {
                self?.isSeedComplete = result
            }
        }
    }

    private func playNextAnimation() {
        guard currentIndex < animationNames.count else {
            finishSequence()
            return
        }

        animationView?.removeFromSuperview()

        let name = animationNames[currentIndex]
        animationView = .init(name: name)
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .playOnce
        animationView?.animationSpeed = 1.0

        guard let animationView = animationView else { return }

        view.addSubview(animationView)

        animationView.play(fromProgress: 0.0, toProgress: 0.9, loopMode: .playOnce) { [weak self] _ in
            self?.currentIndex += 1
            self?.playNextAnimation()
        }
    }

    private func finishSequence() {
        if let onFinish = onFinish {
            onFinish()
        } else {
            let nextVC: UIViewController = MainTabController()
            navigationController?.setViewControllers([nextVC], animated: true)
            navigationController?.isNavigationBarHidden = true
        }
    }
}
