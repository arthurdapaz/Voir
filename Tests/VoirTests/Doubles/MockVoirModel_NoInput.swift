import Foundation
@testable import Voir

final class MockVoirModel_NoInput: VoirModel {
    private(set) var outputSet = false
    var output: MockVoirModelOutput? {
        didSet { outputSet = true }
    }
}
