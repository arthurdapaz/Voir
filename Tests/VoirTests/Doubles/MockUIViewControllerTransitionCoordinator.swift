import UIKit

final class MockUIViewControllerTransitionCoordinator: NSObject, UIViewControllerTransitionCoordinator {
    func animate(alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        false
    }

    func animateAlongsideTransition(in view: UIView?, animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        false
    }

    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) { }

    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) { }

    var isAnimated: Bool = false

    var presentationStyle: UIModalPresentationStyle = .automatic

    var initiallyInteractive: Bool = false

    var isInterruptible: Bool = false

    var isInteractive: Bool = false

    var isCancelled: Bool = false

    var transitionDuration: TimeInterval = .zero

    var percentComplete: CGFloat = .zero

    var completionVelocity: CGFloat = .zero

    var completionCurve: UIView.AnimationCurve = .linear

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        nil
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        nil
    }

    var containerView: UIView = UIView()

    var targetTransform: CGAffineTransform = .identity
}

