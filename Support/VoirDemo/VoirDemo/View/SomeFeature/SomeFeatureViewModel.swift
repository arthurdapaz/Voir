import Foundation
import Voir

protocol SomeFeatureViewModelOutput: AnyObject {
    func updateView(with data: SomeFeatureComponent.DTO)
}

final class SomeFeatureViewModel: VoirModel {
    weak var output: SomeFeatureViewModelOutput?

    // private let dependency: SomeDependency
    // init(dependency: SomeDependency) {
    //     self.dependencies = dependency
    // }
}

extension SomeFeatureViewModel: SomeFeatureComponentInput {
    // Handle View Component Inputs
    func didTapButton() {
        let titleResponse = "Title Updated from a fake network request"
        let subtitleResponse = "New description also obtained via a fake network request"
        let data = SomeFeatureComponent.DTO(title: titleResponse, subtitle: subtitleResponse)
        output?.updateView(with: data)
    }
}
