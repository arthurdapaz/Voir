import UIKit

@resultBuilder
public enum ConstraintsBuilder {
    public static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }

    public static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        expression
    }
}

public extension UIView {
    func activate(@ConstraintsBuilder constraints: () -> [NSLayoutConstraint]) -> VoirTraits {
        VoirTraits(view: self, constraints: constraints())
    }
}
