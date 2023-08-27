import Foundation
import UIKit
@testable import Voir

protocol MockVoirComponentInput: AnyObject {}

final class MockVoirComponent: UIView, VoirComponent {
    private(set) var inputSet = false
    var input: MockVoirComponentInput? {
        didSet { inputSet = true }
    }
    
    private(set) var layoutViewsCalled = false
    func layoutViews() {
        layoutViewsCalled = true
    }
    
    private(set) var bindViewsCalled = false
    func bindViews(with input: MockVoirComponentInput) {
        bindViewsCalled = true
    }

    struct MockDTO {
        let value: Int
    }

    private(set) var updateViewCalled = false
    func updateView(with data: MockDTO) {
        updateViewCalled = true
    }

    private(set) var notifiedStages = [String]()
    func lifecycleUpdate(_ cycle: Lifecycle) {
        notifiedStages.append(String(describing: cycle))
    }
}

extension MockVoirComponent: MockVoirModelOutput {}
