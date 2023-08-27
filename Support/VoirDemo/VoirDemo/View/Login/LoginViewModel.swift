import Foundation
import Voir

protocol DemoViewModelOutput: AnyObject {
    func updateView(with data: LoginComponent.DTO)
}

final class LoginViewModel: VoirModel {
    weak var output: DemoViewModelOutput?

    private let router: RouterProtocol
    init(router: RouterProtocol) {
        self.router = router
    }
}

extension LoginViewModel: LoginComponentInput {
    func didTapLogin(_ username: String?, _ password: String?) {
        router.gotoSomeFeature()
    }
    
    func didTapForgotPassword() {
        let fakeNetworkResponse = "Feature not implemented! Demo purposes only. This message also came from a fake network request"
        output?.updateView(with: fakeNetworkResponse)
    }
}
