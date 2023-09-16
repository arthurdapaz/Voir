import Cartography
import UIKit
import VoirBuilder

final class DisclaimerViewController: UIViewController {

    private let disclaimer = UILabel().is {
        $0.font = .preferredFont(forTextStyle: .largeTitle)
        $0.textColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
        $0.text = "This is a demo of VoirBuilder capabilities. VoirBuilder is an essential part of Voir framework. But since it can help developers build complex UIs in an almost declarative way, I decided to make it available as a standalone library."
        $0.bolding("VoirBuilder").bolding("Voir framework")
        $0.textAlignment = .center
        $0.numberOfLines = .zero
    }

    private let homeButton = UIButton(type: .custom).is {
        $0.setImage(UIImage(systemName: "house.fill"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)
        $0.layer.cornerRadius = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view {
            disclaimer
            homeButton
        }
//        .activate {
//            disclaimer.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -32)
//            disclaimer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
//            disclaimer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
//
//            homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//            homeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
//            homeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
//            homeButton.heightAnchor.constraint(equalToConstant: 48)
//        }
//        .when(.always)

        Cartography.constrain(view, disclaimer, homeButton) { view, disclaimer, homeButton in
            disclaimer.bottom == homeButton.top - 32
            disclaimer.leading == view.safeAreaLayoutGuide.leading + 16
            disclaimer.trailing == view.safeAreaLayoutGuide.trailing - 16

            homeButton.bottom == view.safeAreaLayoutGuide.bottom - 16
            homeButton.leading == view.safeAreaLayoutGuide.leading + 16
            homeButton.trailing == view.safeAreaLayoutGuide.trailing - 16
            homeButton.height == 48
        }.when(view: view, .portrait)

        Cartography.constrain(view, disclaimer, homeButton) { view, disclaimer, homeButton in
            disclaimer.top == view.safeAreaLayoutGuide.top
            disclaimer.bottom == view.safeAreaLayoutGuide.bottom
            disclaimer.leading == view.safeAreaLayoutGuide.leading
            disclaimer.trailing == view.centerX * 1.2

            homeButton.centerY == view.centerY
            homeButton.leading == disclaimer.trailing + 16
            homeButton.trailing == view.safeAreaLayoutGuide.trailing - 16
            homeButton.height == 100
        }.when(view: view, .landscape)


        
        homeButton => { [unowned self] in
            if navigationController?.viewControllers.first == self {
                navigationController?.pushViewController(ViewController(), animated: true)
            } else {
                navigationController?.popViewController(animated: true)
            }
        }

        view.backgroundColor = .white
        title = "Disclaimer"
    }
}
