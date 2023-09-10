import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigation = UINavigationController(rootViewController: DisclaimerViewController())
        navigation.navigationBar.tintColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.4156862745, alpha: 1)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}
