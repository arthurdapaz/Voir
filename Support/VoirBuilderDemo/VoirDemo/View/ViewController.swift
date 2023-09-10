import UIKit

final class ViewController: UIViewController {

    override func loadView() {
        view = ViewComponent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        (view as! ViewComponent).delegate = self
        title = "Voir Demo"
    }
}

extension ViewController: ViewComponentDelegate {
    func loginButtonTapped() {
        navigationController?.pushViewController(DisclaimerViewController(), animated: true)
    }
    
    func forgotPasswordButtonTapped() { }
}
