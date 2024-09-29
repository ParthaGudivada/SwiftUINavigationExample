import SwiftUI
import UIKit

final class TabBarCoordinator: CompositionCoordinator {
    var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinators = [any Coordinator]()
    
    let tabBarController = UITabBarController()
    
    private(set) var firstTabCoordinator: FirstTabCoordinator?
    private(set) var secondTabCoordinator: SecondTabCoordinator?
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let firstTabNC = UINavigationController()
        let firstTabCoordinator = FirstTabCoordinator(navigationController: firstTabNC)
        let secondTabNC = UINavigationController()
        let secondTabCoordinator = SecondTabCoordinator(navigationController: secondTabNC)

        addChild(firstTabCoordinator)
        addChild(secondTabCoordinator)
        
        firstTabCoordinator.start()
        secondTabCoordinator.start()

        tabBarController.viewControllers = [ firstTabNC, secondTabNC ]
        firstTabNC.tabBarItem = UITabBarItem(
            title: "First",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        secondTabNC.tabBarItem = UITabBarItem(
            title: "Second",
            image: UIImage(systemName: "star"),
            tag: 1
        )
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.firstTabCoordinator = firstTabCoordinator
        self.secondTabCoordinator = secondTabCoordinator
    }
    
    func dismissAll(completion: @escaping () -> Void) {
        childCoordinators.forEach { $0.finish() }
        tabBarController.dismiss(animated: true, completion: completion)
    }
    
    deinit {
        print("Deinit TabBarCoordinator")
    }
}
