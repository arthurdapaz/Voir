#if canImport(VoirHooker)
import XCTest
@testable import VoirBuilder

final class VoirHookerTests: XCTestCase {
    func testUIView_whenDidChangeTraitCollection() {
        let view = MockUIView()
        
        view.traitCollectionDidChange(nil)

        XCTAssertTrue(view.notifyOrientationCalled)
    }

    func testUIViewController_whenViewWillAppear() {
        let viewController = MockUIViewController()
        
        viewController.viewWillAppear(false)

        XCTAssertTrue(viewController.notifyOrientationCalled)
    }
}
#endif
