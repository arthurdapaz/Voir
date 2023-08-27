import Foundation
import Voir

protocol ___VARIABLE_moduleName___ViewModelOutput: AnyObject {
    func updateView(with data: ___VARIABLE_moduleName___Component.DTO)
}

final class ___VARIABLE_moduleName___ViewModel: VoirModel {
    weak var output: ___VARIABLE_moduleName___ViewModelOutput?

    // private let dependency: Dependency
    // init(dependency: Dependency) {
    //     self.dependency = dependency
    // }

    func lifecycleUpdate(_ cycle: Lifecycle) {
        // switch stage to intercept viewController events
    }
}

extension ___VARIABLE_moduleName___ViewModel: ___VARIABLE_moduleName___ComponentInput {
    // Handle View Component Inputs and Output a DTO to update ___VARIABLE_moduleName___Component
    // let data = ___VARIABLE_moduleName___Component.DTO()
    // output?.updateView(with: data)
}
