import Foundation
import UIKit
@testable import Voir

final class MockVoirComponent_NoOutput: UIView, VoirComponent {
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

    struct MockDTO { }

    private(set) var updateViewCalled = false
    func updateView(with data: MockDTO) {
        updateViewCalled = true
    }
}
