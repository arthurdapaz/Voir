import UIKit
import VoirBuilder

protocol ViewComponentDelegate: AnyObject {
    func loginButtonTapped()
    func forgotPasswordButtonTapped()
}

final class ViewComponent: UIView {
    weak var delegate: ViewComponentDelegate?

    private lazy var gradient = CAGradientLayer().is {
        $0.drawsAsynchronously = true
        $0.startPoint = CGPoint(x: 0.5, y: 1.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer($0, at: 0)
    }

    private var noiseTimer: Timer?

    private lazy var noiseImage = UIImageView().is {
        $0.generateNoise(with: &noiseTimer)
    }

    private let logoImage = UIImageView().is {
        let image = #imageLiteral(resourceName: "voir")
        $0.image = image
        $0.contentMode = .scaleAspectFit
    }

    private lazy var stackView = UIStackView().is {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
    }

    private let titleLabel = UILabel().is {
        $0.text = "Beautiful, isn't it?"
        $0.numberOfLines = .zero
        $0.font = .boldSystemFont(ofSize: 48)
        $0.textColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    }

    private let subtitleLabel = UILabel().is {
        $0.text = "VoirBuilder works simple. Rotate the Simulator to see the dynamic constraints in action."
        $0.numberOfLines = .zero
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.textColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
        $0.bolding("VoirBuilder").bolding("Rotate the Simulator")
    }

    private let usernameTextField = UITextField().is {
        $0.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 0.5)])
        $0.borderStyle = .roundedRect
        $0.textColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
    }

    private let passwordTextField = UITextField().is {
        $0.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 0.5)])
        $0.borderStyle = .roundedRect
        $0.textColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
        $0.isSecureTextEntry = true
    }

    private let loginButton = UIButton(type: .system).is {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        let color = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        $0.setTitleColor(color, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9323973339, green: 0.9455857343, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 8
    }

    private let forgotPasswordButton = UIButton(type: .system).is {
        $0.setTitle("Forgot Password?", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let color = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
        $0.setTitleColor(color, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.906913703, green: 0.9455857343, blue: 0.9715801946, alpha: 1)
        $0.layer.cornerRadius = 8
    }

    required init() {
        super.init(frame: .zero)
        layoutViews()
        addBindings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = frame
    }

    func layoutViews() {
        self {
            noiseImage
            logoImage
            stackView {
                titleLabel
                subtitleLabel
                usernameTextField
                passwordTextField
                loginButton
                forgotPasswordButton
            }
        }

        activate {
            noiseImage.topAnchor.constraint(equalTo: topAnchor)
            noiseImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            noiseImage.leadingAnchor.constraint(equalTo: leadingAnchor)
            noiseImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        }.when(.always)

        activate {
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            logoImage.heightAnchor.constraint(equalToConstant: 300)

            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 32)
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
            loginButton.heightAnchor.constraint(equalToConstant: 40)
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40)
        }.when(.portrait)

        activate {
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
            logoImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
            logoImage.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20)

            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            stackView.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 20)
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)

            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
            loginButton.heightAnchor.constraint(equalToConstant: 40)
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40)
        }.when(.landscape)

        backgroundColor = .white
        stackView.setCustomSpacing(32, after: passwordTextField)
        setupGradientBackground()
    }

    func addBindings() {
        loginButton => { [unowned self] in
            delegate?.loginButtonTapped()
        }
        forgotPasswordButton => { [unowned self] in
            delegate?.forgotPasswordButtonTapped()
        }
    }
}

extension ViewComponent: CAAnimationDelegate {
    var gradientSet: [[CGColor]] {[
        [#colorLiteral(red: 0.8705882353, green: 0.7803921569, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.7333333333, green: 0.862745098, blue: 1, alpha: 1).cgColor],
        [#colorLiteral(red: 0.7333333333, green: 0.862745098, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.7647058824, green: 0.7803921569, blue: 1, alpha: 1).cgColor],
        [#colorLiteral(red: 0.7647058824, green: 0.7803921569, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.8705882353, green: 0.7803921569, blue: 1, alpha: 1).cgColor]
    ]}

    func setupGradientBackground() {
        gradient.colors = gradientSet[0]
        animateGradient(1)
    }

    func animateGradient(_ set: Int) {
        let colorIndex = (set - 1) % 2 + 1

        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 1.0
        animation.toValue = gradientSet[colorIndex]
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self else { return }
            self.gradient.colors = self.gradientSet[colorIndex]
            animateGradient(set + 1)
        }
        gradient.add(animation, forKey: "colorChange")
        CATransaction.commit()
    }
}

