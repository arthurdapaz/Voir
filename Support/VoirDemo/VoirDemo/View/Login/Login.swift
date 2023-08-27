import UIKit
import Voir

enum LoginFactory {
    static func make(router: RouterProtocol) -> UIViewController {
        let viewModel = LoginViewModel(router: router)
        
        return VoirController(LoginComponent.self, viewModel)
    }
}
