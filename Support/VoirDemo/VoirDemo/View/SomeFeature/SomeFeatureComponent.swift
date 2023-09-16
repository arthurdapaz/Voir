import UIKit
import Voir
import VoirBuilder

protocol SomeFeatureComponentInput: AnyObject {
    func didTapButton()
}

final class SomeFeatureComponent: UIView, VoirComponent {
    weak var input: SomeFeatureComponentInput?

    private let stackView = UIStackView().is {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .top
    }

    private let titleLabel = UILabel().is {
        $0.text = "Template Title"
        $0.textAlignment = .left
        $0.numberOfLines = .zero
        $0.font = .preferredFont(forTextStyle: .largeTitle)
    }

    private let subtitleLabel = UILabel().is {
        $0.text = "Template Subtitle for Demo Purposes"
        $0.textAlignment = .left
        $0.numberOfLines = .zero
    }

    private let someButton = UIButton(type: .system).is {
        $0.setTitle("Template Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    func layoutViews() {
        self {
            stackView {
                titleLabel
                subtitleLabel
            }
            someButton
        }

        activate {
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

            someButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
            someButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            someButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            someButton.heightAnchor.constraint(equalToConstant: 40)
        }.when(.portrait)

        activate {
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            stackView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16)

            someButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            someButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16)
            someButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 16)
            someButton.heightAnchor.constraint(equalToConstant: 40)
        }.when(.landscape)

        backgroundColor = .white
    }

    func bindViews(with input: SomeFeatureComponentInput) {
        someButton.addAction(UIAction { _ in
            input.didTapButton()
        }, for: .touchUpInside)
    }

    func lifecycleUpdate(_ cycle: Lifecycle) {
        switch cycle {
        case .viewDidLoad:
            viewController?.title = "SomeFeature"

        default: break
        }
    }
}

// Update UI with DTO
extension SomeFeatureComponent: SomeFeatureViewModelOutput {
    struct Configuration {
        let title: String
        let subtitle: String
    }

    func updateView(with data: Configuration) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
    }
}
