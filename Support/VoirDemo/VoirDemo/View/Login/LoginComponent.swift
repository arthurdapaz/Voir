import UIKit
import Voir
import VoirBuilder

protocol LoginComponentInput: AnyObject {
    func didTapLogin(_ username: String?, _ password: String?)
    func didTapForgotPassword()
}

final class LoginComponent: UIView, VoirComponent {
    weak var input: LoginComponentInput?

    private let stackView = UIStackView().is {
        $0.axis = .vertical
        $0.spacing = .zero
        $0.alignment = .top
    }

    private let titleLabel = UILabel().is {
        $0.text = "Template Title"
        $0.textAlignment = .left
    }

    private let subtitleLabel = UILabel().is {
        $0.text = "Template Subtitle for Demo Purposes"
        $0.textAlignment = .left
    }

    private let usernameTextField = UITextField().is {
        $0.placeholder = "Username"
        $0.borderStyle = .roundedRect
    }

    private let passwordTextField = UITextField().is {
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        $0.borderStyle = .roundedRect
    }

    private let loginButton = UIButton(type: .system).is {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private let forgotPasswordButton = UIButton(type: .system).is {
        $0.setTitle("Forgot Password?", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

    func layoutViews() {
        self {
            usernameTextField
            passwordTextField
            loginButton
            forgotPasswordButton
        }

        activate {
            usernameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10)
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            loginButton.heightAnchor.constraint(equalToConstant: 40)

            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10)
            forgotPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        }.when(.always)

        backgroundColor = .white
    }

    func bindViews(with input: LoginComponentInput) {
        loginButton => { [unowned self] in
            input.didTapLogin(usernameTextField.text, passwordTextField.text)
        }

        forgotPasswordButton => {
            input.didTapForgotPassword()
        }
    }

    func lifecycleUpdate(_ cycle: Lifecycle) {
        switch cycle {
        case .viewDidLoad:
            viewController?.title = "Login"

        default: break
        }
    }
}

private extension LoginComponent {
    func showLeakTestAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Voilà!", style: .default)

        let leakTestAction = UIAlertAction(title: "Test Leak", style: .default) { _ in
            if let controller = self.viewController {
                controller.navigationController?.setViewControllers([.empty, controller], animated: true)
            }
        }

        alert.addAction(okAction)
        alert.addAction(leakTestAction)

        viewController?.present(alert, animated: true)
    }
}

extension LoginComponent: DemoViewModelOutput {
    func updateView(with data: String) {
        showLeakTestAlert(data)
    }
}
