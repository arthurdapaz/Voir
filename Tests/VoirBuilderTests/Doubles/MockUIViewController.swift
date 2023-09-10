import UIKit
@testable import VoirBuilder

final class MockUIViewController: UIViewController {
    
    private(set) var notifyOrientationCalled = false
    override func notifyOrientation() {
        super.notifyOrientation()
        notifyOrientationCalled = true
    }
}
