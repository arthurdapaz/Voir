import Foundation
@testable import Voir

protocol MockVoirModelOutput: AnyObject {
    func updateView(with data: MockVoirComponent.DTO)
}

final class MockVoirModel: VoirModel {
    private(set) var outputSet = false
    var output: MockVoirModelOutput? {
        didSet { outputSet = true }
    }

    private(set) var notifiedStages = [String]()
    func lifecycleUpdate(_ cycle: Lifecycle) {
        notifiedStages.append(String(describing: cycle))
    }
}

extension MockVoirModel: MockVoirComponentInput {}
