import UIKit
import Voir

enum ___VARIABLE_moduleName___Factory {
    static func make() -> UIViewController {
        // Inject dependencies on ___VARIABLE_moduleName___ViewModel initializer
        let viewModel = ___VARIABLE_moduleName___ViewModel()

        return VoirController(___VARIABLE_moduleName___Component.self, viewModel)
    }
}
