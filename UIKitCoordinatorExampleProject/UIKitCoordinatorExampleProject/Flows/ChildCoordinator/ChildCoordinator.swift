import SwiftUI
import UIKit

final class ChildCoordinator: Coordinator {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinators: [any Coordinator] = []
    let rootNavigationController = UINavigationController()
    
    private lazy var navigationControllers = [rootNavigationController]
    private var topNavigationController: UINavigationController {
        navigationControllers.last ?? rootNavigationController
    }
    
    var pushedDepth: Int {
        topNavigationController.viewControllers.count - 1
    }
    var presentedDepth: Int {
        navigationControllers.count - 1
    }

    func start() {
        let rootScreen = ChildScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        rootNavigationController.pushViewController(vc, animated: true)
    }
    
    func pushNext() {
        let nextScreen = ChildScreen(coordinator: self)
        let vc = UIHostingController(rootView: nextScreen)
        topNavigationController.pushViewController(vc, animated: true)
    }
    
    func popLast() {
        topNavigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        topNavigationController.popToRootViewController(animated: true)
    }
    
    func presentNext() {
        let topNC = topNavigationController
        let nc = UINavigationController()
        navigationControllers.append(nc)
        let nextScreen = ChildScreen(coordinator: self)
        let vc = UIHostingController(rootView: nextScreen)
        nc.viewControllers = [vc]
        topNC.present(nc, animated: true)
    }
    
    func dismissTop() {
        guard topNavigationController != rootNavigationController else { return }
        topNavigationController.dismiss(animated: true)
        navigationControllers.removeLast()
    }
    
    func dismissToRoot() {
        guard rootNavigationController.presentedViewController != nil else {
            return
        }
        rootNavigationController.dismiss(animated: true)
        navigationControllers.removeAll { $0 !== rootNavigationController }
        childCoordinators.forEach { $0.finish() }
    }
    
    func presentChild() {
        let child = FirstTabCoordinator()
        addChild(child)
        child.start()
        child.rootNavigationController.modalPresentationStyle = .fullScreen
        topNavigationController.present(child.rootNavigationController, animated: true)
    }
    
    func dismissToParent() {
        guard rootNavigationController.presentingViewController != nil else { return }
        rootNavigationController.presentingViewController?.dismiss(animated: true)
        finish()
    }
 
    deinit {
        print("Deinit ChildCoordinator")
    }
}
