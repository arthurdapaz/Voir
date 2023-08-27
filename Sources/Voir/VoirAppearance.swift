import protocol UIKit.UIAppearance

public extension UIAppearance {
    
    @inlinable
    @discardableResult
    func voir(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}
