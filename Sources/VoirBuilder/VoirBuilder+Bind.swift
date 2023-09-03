import UIKit

infix operator => : AdditionPrecedence

public func =>(control: UIControl, action: @escaping () -> Void) {
    switch control {
    case is UISlider:
        control.addAction(for: .valueChanged, action)

    case is UIButton:
        control.addAction(for: .touchUpInside, action)

    case is UISwitch:
        control.addAction(for: .valueChanged, action)

    case is UISegmentedControl:
        control.addAction(for: .valueChanged, action)

    case is UIStepper:
        control.addAction(for: .valueChanged, action)

    case is UITextField:
        control.addAction(for: .editingChanged, action)

    case is UIDatePicker:
        control.addAction(for: .valueChanged, action)

    case is UIPageControl:
        control.addAction(for: .valueChanged, action)

    default:
        assertionFailure("Unexpected UIControl type: \(control)")
    }
}

private extension UIControl {
    private final class ActionClosure: NSObject {
        private let closure: () -> Void

        fileprivate init(_ closure: @escaping () -> Void) {
            self.closure = closure
        }

        @objc
        func invoke() {
            closure()
        }
    }

    func addAction(for controlEvents: Event, _ closure: @escaping () -> Void) {
        let sleeve = ActionClosure(closure)
        addTarget(sleeve, action: #selector(ActionClosure.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "", sleeve, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
