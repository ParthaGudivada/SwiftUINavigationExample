import SwiftUI
import UIKit

final class ChildCoordinator: FlowCoordinator {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinator: Coordinator?
    
    private let startNavigationController: UINavigationController
    private var navigationControllers = [UINavigationController]()
    private var topNavigationController: UINavigationController {
        navigationControllers.last ?? startNavigationController
    }
    private var rootNavigationController: UINavigationController {
        navigationControllers.first ?? startNavigationController
    }
    private var routePresentationDelegates = [PresentationDelegate]()
    
    var pushedDepth: Int {
        topNavigationController.viewControllers.count - 1
    }
    var presentedDepth: Int {
        navigationControllers.count - 1
    }
    
    init(navigationController: UINavigationController) {
        startNavigationController = navigationController
    }

    func start() {
        let rootScreen = ChildScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        let nc = UINavigationController(rootViewController: vc)
        navigationControllers.append(nc)
        let presentationDelegate = PresentationDelegate { [weak self] in
            self?.finish()
        }
        nc.presentationController?.delegate = presentationDelegate
        routePresentationDelegates.append(presentationDelegate)
        if let sheet = nc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        startNavigationController.present(nc, animated: true)
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
        let presentationDelegate = PresentationDelegate { [weak self] in
            self?.navigationControllers.removeLast()
            self?.routePresentationDelegates.removeLast()
        }
        nc.presentationController?.delegate = presentationDelegate
        routePresentationDelegates.append(presentationDelegate)
        topNC.present(nc, animated: true)
    }
    
    func dismissTop() {
        guard topNavigationController != rootNavigationController else { return }
        topNavigationController.dismiss(animated: true)
        routePresentationDelegates.removeLast()
        navigationControllers.removeLast()
    }
    
    func dismissToRoot() {
        guard rootNavigationController.presentedViewController != nil else {
            return
        }
        rootNavigationController.dismiss(animated: true)
        navigationControllers.removeLast(navigationControllers.count - 1)
        routePresentationDelegates.removeLast(routePresentationDelegates.count - 1)
        childCoordinator?.finish()
    }
    
    func startFirstTabCoordinator() {
        let child = FirstTabCoordinator(navigationController: topNavigationController)
        addChild(child)
        child.startFromChild()
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
