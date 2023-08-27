import UIKit
import Voir

protocol ___VARIABLE_moduleName___ComponentInput: AnyObject {
    // Template
}

final class ___VARIABLE_moduleName___Component: UIView, VoirComponent {
    weak var input: ___VARIABLE_moduleName___ComponentInput?

    // UIControls

    func layoutViews() {
        // Use VoirBuilder
    }

    func bindViews(with input: ___VARIABLE_moduleName___ComponentInput) {
        // Link UIControls to ___VARIABLE_moduleName___ComponentInput methods
    }

    func lifecycleUpdate(_ cycle: Lifecycle) {
        // switch stage to intercept viewController events
    }
}

extension ___VARIABLE_moduleName___Component: ___VARIABLE_moduleName___ViewModelOutput {
    struct Configuration {
    }

    func updateView(with data: Configuration) {
        // Update UI with DTO
    }
}
