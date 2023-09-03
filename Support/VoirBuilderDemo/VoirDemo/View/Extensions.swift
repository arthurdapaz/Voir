import UIKit

extension UILabel {
    @discardableResult
    func bolding(_ substring: String) -> Self {
        let current: NSAttributedString
        if let attributedText {
            current = NSAttributedString(attributedString: attributedText)
        } else {
            current = NSAttributedString(string: text ?? "")
        }

        let attributedString = NSMutableAttributedString(attributedString: current)
        let range = attributedString.mutableString.range(of: substring)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: font.pointSize), range: range)
        attributedText = attributedString

        return self
    }
}

extension UIImageView {
    func generateNoise(with noiseTimer: inout Timer?) {
        noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            DispatchQueue.main.async {
                self.image = .noiseTexture(size: self.bounds.size, intensity: 0.1)
            }
        }
    }
}

extension UIImage {
    static func noiseTexture(size: CGSize, intensity: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(UIColor.systemBlue.withAlphaComponent(0.2).cgColor)

        for _ in 0..<Int(size.width * size.height * intensity) {
            let randomX = CGFloat.random(in: 0..<size.width)
            let randomY = CGFloat.random(in: 0..<size.height)
            context.fill(CGRect(x: randomX, y: randomY, width: 1, height: 1))
        }

        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

extension UIViewController {
    func notifyOrientation() {
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact {
            view.orientation = .portrait
        } else {
            view.orientation = .landscape
        }
    }
}

extension UIView {
    func notifyOrientation() {
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact {
            orientation = .portrait
        } else {
            orientation = .landscape
        }
    }
}
