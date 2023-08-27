import UIKit

protocol RouterProtocol: AnyObject {
    func gotoLogin()
    func gotoSomeFeature()
}

final class Router: RouterProtocol {
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func gotoLogin() {
        let controller = LoginFactory.make(router: self)
        navigationController.pushViewController(controller, animated: true)
    }

    func gotoSomeFeature() {
        let controller = SomeFeatureFactory.make()
        navigationController.pushViewController(controller, animated: true)
    }
}
