import XCTest
@testable import Voir

extension XCTestCase {
    func expectFatalError(
        with expectedMessage: String,
        file: StaticString = #file,
        line: UInt = #line,
        testcase: @escaping () -> Void
    ) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String = ""

        triggerFatalError = { (message, _, _) in
            assertionMessage = message()
            DispatchQueue.main.async {
                expectation.fulfill()
            }
            Thread.exit()
            Swift.fatalError("will never be executed since thread exits")
        }

        DispatchQueue.main.async {
            Thread(block: testcase).start()
        }

        waitForExpectations(timeout: 30) { _ in
            XCTAssertEqual(expectedMessage, assertionMessage)
            triggerFatalError = Swift.fatalError
        }
    }
}
