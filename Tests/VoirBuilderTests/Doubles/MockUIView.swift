import UIKit
@testable import VoirBuilder

final class MockUIView: UIView {
    var mockTraitCollection: UITraitCollection?

    override var traitCollection: UITraitCollection {
        mockTraitCollection ?? super.traitCollection
    }

    private(set) var notifyOrientationCalled = false
    override func notifyOrientation() {
        super.notifyOrientation()
        notifyOrientationCalled = true
    }
}
