import XCTest
@testable import Voir

final class VoirBuilderTests: XCTestCase {

    // Test the VoirBuilder buildBlock and buildExpression methods
    func testVoirBuilder() {
        let view1 = UIView()
        let view2 = UIView()

        let result = VoirBuilder.buildBlock(
            VoirBuilder.buildExpression(view1),
            VoirBuilder.buildExpression(view2)
        )

        XCTAssertEqual(result, [view1, view2])
    }

    // Test the ConstraintsBuilder buildBlock and buildExpression methods
    func testConstraintsBuilder() {
        let constraint1 = NSLayoutConstraint()
        let constraint2 = NSLayoutConstraint()

        let result = ConstraintsBuilder.buildBlock(
            ConstraintsBuilder.buildExpression(constraint1),
            ConstraintsBuilder.buildExpression(constraint2)
        )

        XCTAssertEqual(result, [constraint1, constraint2])
    }

    // Test the `callAsFunction` method for adding subviews
    func testCallAsFunctionMethod() {
        let superview = UIView()
        let subview1 = UIView()
        let subview2 = UIView()

        let stackview = UIStackView()
        let arrangedSubview1 = UIView()
        let arrangedSubview2 = UIView()

        superview {
            subview1
            subview2
            stackview {
                arrangedSubview1
                arrangedSubview2
            }
        }

        XCTAssertTrue(superview.subviews.contains(subview1))
        XCTAssertTrue(superview.subviews.contains(subview2))
        XCTAssertTrue(stackview.arrangedSubviews.contains(arrangedSubview1))
        XCTAssertTrue(stackview.arrangedSubviews.contains(arrangedSubview2))
    }

    // Test the `activate` method for activating constraints
    func testActivateMethod() {
        let view = UIView()

        let constraint1 = view.widthAnchor.constraint(equalToConstant: 50)
        let constraint2 = view.heightAnchor.constraint(equalToConstant: 50)

        view.activate {
            constraint1
            constraint2
        }

        XCTAssertTrue(view.constraints.contains(constraint1))
        XCTAssertTrue(view.constraints.contains(constraint2))
    }

    // Test the `make` method for customizing the view
    func testMakeMethod() {
        let view = UIView()
        var isCustomized = false

        _ = view.make {
            isCustomized = true
        }

        XCTAssertTrue(isCustomized)
    }

    // Test UIControl elements easy customization
    func testUIAppearanceVoir() {
        let element = UIView().voir {
            $0.backgroundColor = .white
            $0.tag = 1000
        }

        XCTAssertEqual("\(type(of: element))", "UIView")
        XCTAssertEqual(element.backgroundColor, .white)
        XCTAssertEqual(element.tag, 1000)
    }
}
