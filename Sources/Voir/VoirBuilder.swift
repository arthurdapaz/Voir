import UIKit

@resultBuilder
public enum VoirBuilder {
    public static func buildBlock(_ components: [UIView]...) -> [UIView] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: UIView) -> [UIView] {
        [expression]
    }
}

@resultBuilder
public enum ConstraintsBuilder {
    public static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [expression]
    }
}

public extension UIView {
    private func mount(_ subviews: [UIView]) {
        if let stackView = self as? UIStackView {
            subviews.forEach(stackView.addArrangedSubview)
        } else {
            subviews.forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
        }
    }

    @discardableResult
    func callAsFunction(@VoirBuilder subviews: () -> [UIView]) -> UIView {
        mount(subviews())
        return self
    }

    @discardableResult
    func activate(@ConstraintsBuilder activate: () -> [NSLayoutConstraint]) -> UIView {
        NSLayoutConstraint.activate(activate())
        return self
    }

    @discardableResult
    func make(customization: () -> Void) -> UIView {
        customization()
        return self
    }
}
