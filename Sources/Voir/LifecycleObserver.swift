import UIKit

public protocol LifecycleObserver: AnyObject {
    func lifecycleUpdate(_ cycle: Lifecycle)
}

public extension LifecycleObserver {
    func lifecycleUpdate(_ cycle: Lifecycle) {}
}

public enum Lifecycle {
    case viewDidLoad(_ controller: UIViewController)
    case viewWillAppear(_ controller: UIViewController, _ animated: Bool)
    case viewDidAppear(_ controller: UIViewController, _ animated: Bool)
    case viewWillDisappear(_ controller: UIViewController, _ animated: Bool)
    case viewDidDisappear(_ controller: UIViewController, _ animated: Bool)
    case didBecomeActive(_ controller: UIViewController)
    case willEnterForeground(_ controller: UIViewController)
    case willBecomeInactive(_ controller: UIViewController)
    case viewWillTransition(_ controller: UIViewController, _ size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator)
    case traitCollectionDidChange(_ controller: UIViewController, _ previousTraitCollection: UITraitCollection?)
}
