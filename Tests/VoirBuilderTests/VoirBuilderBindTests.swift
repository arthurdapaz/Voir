import UIKit
import XCTest
@testable import VoirBuilder

final class VoirBuilderBindTests: XCTestCase {
    func testUISlider_Binding() throws {
        let control = UISlider()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIButton_Binding() throws {
        let control = UIButton()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUISwitch_Binding() throws {
        let control = UISwitch()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUISegmentedControl_Binding() throws {
        let control = UISegmentedControl()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIStepper_Binding() throws {
        let control = UIStepper()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUITextField_Binding() throws {
        let control = UITextField()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIDatePicker_Binding() throws {
        let control = UIDatePicker()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }

    func testUIPageControl_Binding() throws {
        let control = UIPageControl()
        control => { }
        XCTAssertEqual(control.allTargets.count, 1)
    }
}
