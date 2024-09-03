import SwiftUI
import UIKit

final class TabBarCoordinator: Coordinator {
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
        let firstTabCoordinator = FirstTabCoordinator()
        let secondTabCoordinator = SecondTabCoordinator()

        addChild(firstTabCoordinator)
        addChild(secondTabCoordinator)
        
        firstTabCoordinator.start()
        secondTabCoordinator.start()

        tabBarController.viewControllers = [
            firstTabCoordinator.rootNavigationController,
            secondTabCoordinator.navigationController
        ]
        firstTabCoordinator.rootNavigationController.tabBarItem = UITabBarItem(
            title: "First",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        secondTabCoordinator.navigationController.tabBarItem = UITabBarItem(
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
        childCoordinators.forEach { $0.childCoordinators.removeAll() }
        tabBarController.dismiss(animated: true, completion: completion)
    }
    
    func startChildCoordinator() {
        let child = ChildCoordinator()
        addChild(child)
        child.start()
        tabBarController.present(child.rootNavigationController, animated: true)
    }
    
    deinit {
        print("Deinit TabBarCoordinator")
    }
}
