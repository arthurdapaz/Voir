import UIKit

public protocol IsVoirable {}

public extension IsVoirable where Self: Any {
    @discardableResult
    func `is`(_ this: (Self) throws -> Void) rethrows -> Self {
        try this(self)
        return self
    }
}

extension UIView: IsVoirable {}
extension CALayer: IsVoirable {}
