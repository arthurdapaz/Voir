import UIKit

public protocol LifecycleObserver: AnyObject {
    func lifecycleUpdate(_ cycle: Lifecycle)
}

public extension LifecycleObserver {
    func lifecycleUpdate(_ cycle: Lifecycle) {}
}

public enum Lifecycle {
    case viewDidLoad
    case viewWillAppear(_ animated: Bool)
    case viewDidAppear(_ animated: Bool)
    case viewWillDisappear(_ animated: Bool)
    case viewDidDisappear(_ animated: Bool)
    case didBecomeActive
    case willEnterForeground
    case willBecomeInactive
    case viewWillTransition(_ size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator)
    case traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
}
