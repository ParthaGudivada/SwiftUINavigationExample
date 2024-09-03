import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var tabBarCoordinator: TabBarCoordinator?
    private let deeplinkCoordinator = DeeplinkCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setup(scene: scene)
        addDeeplinkHandlers()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        print(url.absoluteString)
        deeplinkCoordinator.handleURL(url)
    }
    
    private func setup(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window else { return }
        let tabCoordinator = TabBarCoordinator(window: window)
        tabCoordinator.start()
        window.rootViewController = tabCoordinator.tabBarController
        window.makeKeyAndVisible()
        tabBarCoordinator = tabCoordinator
    }
    
    private func addDeeplinkHandlers() {
        guard let tabBarCoordinator else { return }
        if let firstTabCoordinator = tabBarCoordinator.firstTabCoordinator {
            deeplinkCoordinator.addHandler(
                FirstTabDeeplinkHandler(
                    tabBarConroller: tabBarCoordinator.tabBarController,
                    firstTabCoordinator: firstTabCoordinator
                )
            )
        }
        deeplinkCoordinator.addHandler(
            ChildDeeplinkHandler(tabBarCoordinator: tabBarCoordinator)
        )
    }
}
