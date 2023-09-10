import UIKit

public struct VoirTraits {
    public enum Orientation: Hashable {
        case always
        case portrait
        case landscape

        fileprivate init(traitCollection: UITraitCollection) {
            self = traitCollection.verticalSizeClass == .compact ? .landscape : .portrait
        }
    }

    fileprivate let view: UIView
    fileprivate let constraints: [NSLayoutConstraint]

    public func when(_ orientation: Orientation) {
        guard orientation != .always else {
            NSLayoutConstraint.activate(constraints)
            return
        }
        view.orientedConstraints[orientation] = constraints
    }
}

extension UIView {
    private static var orientedConstraintsKey: UInt8 = 0
    private static var orientationKey: UInt8 = 0

    fileprivate var orientedConstraints: [VoirTraits.Orientation: [NSLayoutConstraint]] {
        get { objc_getAssociatedObject(self, &Self.orientedConstraintsKey) as? [VoirTraits.Orientation: [NSLayoutConstraint]] ?? [:] }
        set { objc_setAssociatedObject(self, &Self.orientedConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    var orientation: VoirTraits.Orientation {
        get { objc_getAssociatedObject(self, &Self.orientationKey) as? VoirTraits.Orientation ?? .portrait }
        set {
            objc_setAssociatedObject(self, &Self.orientationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            enableConstraints(for: newValue)
        }
    }

    private func enableConstraints(for orientation: VoirTraits.Orientation) {
        guard !orientedConstraints[orientation, default: []].isEmpty else { return }

        let switchableOrientations: [VoirTraits.Orientation] = [.portrait, .landscape]
        switchableOrientations
            .filter { $0 != orientation }
            .forEach { disableOrientation in
                orientedConstraints[disableOrientation, default: []].forEach { $0.isActive = false }
            }

        orientedConstraints[orientation, default: []].forEach { $0.isActive = true }
    }
}

// MARK: - VoirHooker API Approach
public extension UIView {
    func activate(@ConstraintsBuilder constraints: () -> [NSLayoutConstraint]) -> VoirTraits {
        VoirTraits(view: self, constraints: constraints())
    }

    @objc
    func notifyOrientation() {
        orientation = .init(traitCollection: traitCollection)
    }
}

public extension UIViewController {
    @objc
    func notifyOrientation() {
        view.orientation = .init(traitCollection: traitCollection)
    }
}
