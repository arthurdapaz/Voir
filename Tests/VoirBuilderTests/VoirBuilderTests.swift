import XCTest
@testable import VoirBuilder

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

    func testConstraintsBuilder_WhenIndividualConstraints() {
        let constraint1 = NSLayoutConstraint()
        let constraint2 = NSLayoutConstraint()

        let result = ConstraintsBuilder.buildBlock(
            ConstraintsBuilder.buildExpression(constraint1),
            ConstraintsBuilder.buildExpression(constraint2)
        )

        XCTAssertEqual(result, [constraint1, constraint2])
    }

    func testConstraintsBuilder_WhenArrayOfConstraints() {
        let constraint1 = NSLayoutConstraint()
        let constraint2 = NSLayoutConstraint()

        let result = ConstraintsBuilder.buildBlock(
            ConstraintsBuilder.buildExpression([constraint1, constraint2])
        )

        XCTAssertEqual(result, [constraint1, constraint2])
    }

    func testCallAsFunction_IncludingStackViews() {
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

    func testActivateConstraints_WhenDeviceIsPortrait() {
        let view = UIViewMock()

        let constraint1 = view.widthAnchor.constraint(equalToConstant: 50)
        let constraint2 = view.heightAnchor.constraint(equalToConstant: 50)

        view.activate {
            constraint1
            constraint2
        }.when(.portrait)

        view.mockTraitCollection = UITraitCollection(traitsFrom: [
            UITraitCollection(horizontalSizeClass: .compact),
            UITraitCollection(verticalSizeClass: .regular)
        ])
        view.notifyOrientation()

        XCTAssertTrue(view.constraints.contains(constraint1))
        XCTAssertTrue(view.constraints.contains(constraint2))
    }

    func testActivateConstraints_WhenDeviceIsLandscpae() {
        let view = UIViewMock()

        let constraint1 = view.widthAnchor.constraint(equalToConstant: 50)
        let constraint2 = view.heightAnchor.constraint(equalToConstant: 50)

        view.activate {
            constraint1
            constraint2
        }.when(.landscape)

        view.mockTraitCollection = UITraitCollection(traitsFrom: [
            UITraitCollection(horizontalSizeClass: .regular),
            UITraitCollection(verticalSizeClass: .compact)
        ])
        view.notifyOrientation()

        XCTAssertTrue(view.constraints.contains(constraint1))
        XCTAssertTrue(view.constraints.contains(constraint2))
    }

    // Test UIControl elements easy customization
    func testIsThis() {
        let element = UIView().is {
            $0.backgroundColor = .white
            $0.tag = 1000
        }

        XCTAssertEqual("\(type(of: element))", "UIView")
        XCTAssertEqual(element.backgroundColor, .white)
        XCTAssertEqual(element.tag, 1000)
    }
}

private class UIViewMock: UIView {
    public var mockTraitCollection: UITraitCollection?

    override var traitCollection: UITraitCollection {
        mockTraitCollection ?? super.traitCollection
    }
}
