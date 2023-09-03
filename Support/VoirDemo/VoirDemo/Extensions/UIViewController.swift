import UIKit

extension UIViewController {
    static var empty: UIViewController {
        let emptyController = UIViewController()

        let label = UILabel()
        label.text = "Go ahead and launch the Memory Graph debugger in Xcode. In the absence of any memory leaks, you'll find that the Memory Graph wont't reveal instances of \"SomeFeature\" or \"Login\" in debug navigator."
        label.numberOfLines = 0
        label.textAlignment = .center

        emptyController
            .view { label }
            .activate {
                label.centerYAnchor.constraint(equalTo: emptyController.view.safeAreaLayoutGuide.centerYAnchor, constant: -128)
                label.leadingAnchor.constraint(equalTo: emptyController.view.leadingAnchor, constant: 32)
                label.trailingAnchor.constraint(equalTo: emptyController.view.trailingAnchor, constant: -32)
            }.when(.always)

        emptyController.title = "Test Memory Leak"
        emptyController.view.backgroundColor = .white

        return emptyController
    }
}
