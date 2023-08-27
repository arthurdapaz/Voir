import UIKit
import Voir

enum SomeFeatureFactory {
    static func make() -> UIViewController {
        // Inject dependencies on ViewModel initializer
        let viewModel = SomeFeatureViewModel()

        return VoirController(SomeFeatureComponent.self, viewModel)
    }
}
