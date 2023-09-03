import UIKit

final class ViewController: UIViewController {

    override func loadView() {
        view = ViewComponent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notifyOrientation()

        (view as! ViewComponent).delegate = self
    }
}

extension ViewController: ViewComponentDelegate {
    func loginButtonTapped() {
        navigationController?.pushViewController(DisclaimerViewController(), animated: true)
    }
    
    func forgotPasswordButtonTapped() { }
}
