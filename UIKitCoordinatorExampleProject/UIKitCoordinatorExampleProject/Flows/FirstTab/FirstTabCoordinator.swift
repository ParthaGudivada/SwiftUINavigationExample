import SwiftUI
import UIKit

final class FirstTabCoordinator: FlowCoordinator {
    
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
        navigationControllers.append(startNavigationController)
        let rootScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        startNavigationController.setViewControllers([vc], animated: false)
    }

    func startFromChild() {
        let rootScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        let nc = UINavigationController(rootViewController: vc)
        navigationControllers.append(nc)
        nc.modalPresentationStyle = .fullScreen
        startNavigationController.present(nc, animated: true)
    }
    
    func pushNext(animated: Bool = true) {
        let nextScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: nextScreen)
        topNavigationController.pushViewController(vc, animated: animated)
    }
    
    func popLast(animated: Bool = true) {
        topNavigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        topNavigationController.popToRootViewController(animated: animated)
    }
    
    func presentNext(animated: Bool = true) {
        let topNC = topNavigationController
        let nc = UINavigationController()
        navigationControllers.append(nc)
        let nextScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: nextScreen)
        nc.viewControllers = [vc]
        let presentationDelegate = PresentationDelegate { [weak self] in
            self?.navigationControllers.removeLast()
            self?.routePresentationDelegates.removeLast()
        }
        nc.presentationController?.delegate = presentationDelegate
        routePresentationDelegates.append(presentationDelegate)
        topNC.present(nc, animated: animated)
    }
    
    func dismissTop(animated: Bool = true) {
        guard topNavigationController != rootNavigationController else { return }
        topNavigationController.dismiss(animated: animated)
        routePresentationDelegates.removeLast()
        navigationControllers.removeLast()
    }
    
    func dismissToRoot(animated: Bool = true) {
        guard rootNavigationController.presentedViewController != nil else {
            return
        }
        rootNavigationController.dismiss(animated: animated)
        navigationControllers.removeLast(navigationControllers.count - 1)
        routePresentationDelegates.removeAll()
        childCoordinator?.finish()
    }
    
    func startChildCoordinator() {
        let child = ChildCoordinator(navigationController: topNavigationController)
        addChild(child)
        child.start()
    }
    
    func dismissToParent() {
        guard rootNavigationController.presentingViewController != nil else { return }
        rootNavigationController.presentingViewController?.dismiss(animated: true)
        finish()
    }
    
    deinit {
        print("Deinit FirstTabCoordinator")
    }
}
