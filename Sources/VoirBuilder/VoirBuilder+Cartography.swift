#if canImport(Cartography)
import Cartography
import UIKit

extension ConstraintGroup {
    public func when(view: UIView, _ orientation: VoirOrientation) {
        if orientation == .always {
            active = true
            return
        } else {
            active = false
        }
        view.constraintGroups[orientation] = self
    }
}

extension UIView {
    private static var constraintGroupKey: UInt8 = 0

    fileprivate var constraintGroups: [VoirOrientation: ConstraintGroup] {
        get { objc_getAssociatedObject(self, &Self.constraintGroupKey) as? [VoirOrientation: ConstraintGroup] ?? [:] }
        set { objc_setAssociatedObject(self, &Self.constraintGroupKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    func enableConstraintGroup(for orientation: VoirOrientation) {
        let switchableOrientations: [VoirOrientation] = [.portrait, .landscape]
        switchableOrientations
            .filter { $0 != orientation }
            .forEach { disableOrientation in
                constraintGroups[disableOrientation, default: .init()].active = false
            }

        constraintGroups[orientation, default: .init()].active = true
    }
}
#endif
