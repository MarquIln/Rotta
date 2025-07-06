import AVFoundation
import UIKit

extension UIView {
    func shake(
        duration: CFTimeInterval = 0.4,
        values: [CGFloat] = [-8, 8, -6, 6, -4, 4, 0]
    ) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = values
        layer.add(animation, forKey: "shake")
    }

    func f1EngineAnimation() {
        let animationX = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animationX.timingFunction = CAMediaTimingFunction(name: .linear)
        animationX.duration = 0.08
        animationX.values = [-3, 3, -4, 4, -2.5, 2.5, 0]
        animationX.repeatCount = .infinity

        let animationY = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animationY.timingFunction = CAMediaTimingFunction(name: .linear)
        animationY.duration = 0.09
        animationY.values = [-2, 2, -2.5, 2.5, -1.5, 1.5, 0]
        animationY.repeatCount = .infinity

        layer.add(animationX, forKey: "engineX")
        layer.add(animationY, forKey: "engineY")
    }

    func f1BrakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.2
        animation.values = [-6, 6, -5, 5, -4, 4, -2, 2, 0]
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "brake")
    }

    func f1TireAnimation() {
        let animationY = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animationY.timingFunction = CAMediaTimingFunction(name: .linear)
        animationY.duration = 0.18
        animationY.values = [-2.5, 2.5, -3, 3, -2, 2, 0]
        animationY.repeatCount = .infinity

        let animationX = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animationX.timingFunction = CAMediaTimingFunction(name: .linear)
        animationX.duration = 0.25
        animationX.values = [-1.5, 1.5, -1, 1, 0]
        animationX.repeatCount = .infinity

        layer.add(animationY, forKey: "tireY")
        layer.add(animationX, forKey: "tireX")
    }

    func f1AeroAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.4
        animation.values = [-1.5, 1.5, -2, 2, -1, 1, 0]
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "aero")
    }

    func f1SuspensionAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 0.15
        animation.values = [-4, 4, -5, 5, -3, 3, -2, 2, 0]
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "suspension")
    }

    func f1GearboxAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 0.3
        animation.values = [-5, 5, -4, 4, -6, 6, -3, 3, 0]
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "gearbox")
    }

    func stopAllF1Animations() {
        layer.removeAnimation(forKey: "engineX")
        layer.removeAnimation(forKey: "engineY")
        layer.removeAnimation(forKey: "brake")
        layer.removeAnimation(forKey: "tireY")
        layer.removeAnimation(forKey: "tireX")
        layer.removeAnimation(forKey: "aero")
        layer.removeAnimation(forKey: "suspension")
        layer.removeAnimation(forKey: "gearbox")
    }

    func formulaGearShiftHaptic() {
        f1GearboxAnimation()
        let haptic = UIImpactFeedbackGenerator(style: .rigid)
        haptic.prepare()
        haptic.impactOccurred(intensity: 1.0)
    }

    func formulaEngineHaptic(formula: FormulaType) {
        f1EngineAnimation()
        let haptic = UIImpactFeedbackGenerator(style: .heavy)
        haptic.prepare()
        haptic.impactOccurred(intensity: 1.0)
    }

    func playF1Sound(named soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3")
        else { return }
        let url = URL(fileURLWithPath: path)

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Erro ao reproduzir som: \(error)")
        }
    }
}
