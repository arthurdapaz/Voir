import UIKit
import XCTest
@testable import VoirBuilder

final class VoirBuilderBindTests: XCTestCase {
    func testUISlider_Binding() throws {
        let control = UISlider()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIButton_Binding() throws {
        let control = UIButton()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUISwitch_Binding() throws {
        let control = UISwitch()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUISegmentedControl_Binding() throws {
        let control = UISegmentedControl()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIStepper_Binding() throws {
        let control = UIStepper()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUITextField_Binding() throws {
        let control = UITextField()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIDatePicker_Binding() throws {
        let control = UIDatePicker()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIPageControl_Binding() throws {
        let control = UIPageControl()
        XCTAssertEqual(control.allTargets.count, .zero)
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }
}
