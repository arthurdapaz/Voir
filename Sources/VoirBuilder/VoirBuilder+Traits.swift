import UIKit

public enum VoirOrientation: Hashable {
    case always
    case portrait
    case landscape

    fileprivate init(traitCollection: UITraitCollection) {
        self = traitCollection.verticalSizeClass == .compact ? .landscape : .portrait
    }
}

public struct VoirTraits {
    fileprivate let view: UIView
    fileprivate let constraints: [NSLayoutConstraint]

    init(view: UIView, constraints: [NSLayoutConstraint]) {
        self.view = view
        self.constraints = constraints
    }

    public func when(_ orientation: VoirOrientation) {
        if orientation == .always {
            NSLayoutConstraint.activate(constraints)
            return
        }
        view.orientedConstraints[orientation] = constraints
    }
}

extension UIView {
    private static var orientedConstraintsKey: UInt8 = 0
    private static var orientationKey: UInt8 = 0

    fileprivate var orientedConstraints: [VoirOrientation: [NSLayoutConstraint]] {
        get { objc_getAssociatedObject(self, &Self.orientedConstraintsKey) as? [VoirOrientation: [NSLayoutConstraint]] ?? [:] }
        set { objc_setAssociatedObject(self, &Self.orientedConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    private func enableConstraints(for orientation: VoirOrientation) {
        guard !orientedConstraints[orientation, default: []].isEmpty else { return }

        let switchableOrientations: [VoirOrientation] = [.portrait, .landscape]
        switchableOrientations
            .filter { $0 != orientation }
            .forEach { disableOrientation in
                orientedConstraints[disableOrientation, default: []].forEach { $0.isActive = false }
            }

        orientedConstraints[orientation, default: []].forEach { $0.isActive = true }
    }

    var orientation: VoirOrientation {
        get { objc_getAssociatedObject(self, &Self.orientationKey) as? VoirOrientation ?? .portrait }
        set {
            objc_setAssociatedObject(self, &Self.orientationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            enableConstraints(for: newValue)
            #if canImport(Cartography)
            enableConstraintGroup(for: orientation)
            #endif
        }
    }
}

// MARK: - VoirHooker Interface
public extension UIView {
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
