import UIKit

public protocol VoirComponent: UIView, InputSender, LifecycleObserver {
    associatedtype DTO
    var viewController: UIViewController? { get }

    func layoutViews()
    func bindViews(with input: Input)
    func updateView(with data: DTO)
}

public extension VoirComponent {
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }

    var navigationController: UINavigationController? {
        viewController?.navigationController
    }
}
