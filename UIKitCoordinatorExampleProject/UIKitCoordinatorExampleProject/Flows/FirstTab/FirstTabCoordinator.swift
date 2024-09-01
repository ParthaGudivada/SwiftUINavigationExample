import SwiftUI
import UIKit

final class FirstTabCoordinator: Coordinator {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinators: [any Coordinator] = []
    let rootNavigationController = UINavigationController()
    lazy var navigationControllers = [rootNavigationController]
    var topNavigationController: UINavigationController {
        navigationControllers.last ?? rootNavigationController
    }
    var presentationDelegate: PresentationDelegate?

    func start() {
        let rootScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func pushNext() {
        let nextScreen = FirstTabScreen(coordinator: self)
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
        let nextScreen = FirstTabScreen(coordinator: self)
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
    }
    
    func presentChild() {
        let child = ChildCoordinator()
        addChild(child)
        
        let presentationDelegate = PresentationDelegate { [weak child] in
            child?.finish()
        }
        child.rootNavigationController.presentationController?.delegate = presentationDelegate
        self.presentationDelegate = presentationDelegate
        
        if let sheet = child.rootNavigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        topNavigationController.present(child.rootNavigationController, animated: true)
    }
    
    func dismissToParent() {
        rootNavigationController.presentingViewController?.dismiss(animated: true)
        finish()
    }
    
    deinit {
        print("Deinit FirstTabCoordinator")
    }
}
