import XCTest
@testable import VoirBuilder

final class VoirHookerTests: XCTestCase {
    func testUIView_whenDidChangeTraitCollection() {
        let view = MockUIView()
        
        view.traitCollectionDidChange(nil)

        XCTAssertTrue(view.notifyOrientationCalled)
    }

    func testUIViewController_whenViewDidLoad() {
        let viewController = MockUIViewController()
        
        viewController.viewDidLoad()

        XCTAssertTrue(viewController.notifyOrientationCalled)
    }
}
