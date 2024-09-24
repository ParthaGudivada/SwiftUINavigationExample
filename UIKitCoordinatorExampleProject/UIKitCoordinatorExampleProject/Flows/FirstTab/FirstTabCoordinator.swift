import SwiftUI
import UIKit

final class FirstTabCoordinator: FlowCoordinator {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinator: Coordinator?
    let rootNavigationController = UINavigationController()
    
    private lazy var navigationControllers = [rootNavigationController]
    private var topNavigationController: UINavigationController {
        navigationControllers.last ?? rootNavigationController
    }
    private var childPresentationDelegate: PresentationDelegate?
    private var routePresentationDelegates = [PresentationDelegate]()
    
    var pushedDepth: Int {
        topNavigationController.viewControllers.count - 1
    }
    var presentedDepth: Int {
        navigationControllers.count - 1
    }

    func start() {
        let rootScreen = FirstTabScreen(coordinator: self)
        let vc = UIHostingController(rootView: rootScreen)
        rootNavigationController.pushViewController(vc, animated: false)
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
        navigationControllers.removeAll { $0 !== rootNavigationController }
        routePresentationDelegates.removeAll()
        childCoordinator?.finish()
    }
    
    func presentChild() {
        let child = ChildCoordinator()
        addChild(child)
        child.start()
        
        let presentationDelegate = PresentationDelegate { [weak child] in
            child?.finish()
        }
        child.rootNavigationController.presentationController?.delegate = presentationDelegate
        self.childPresentationDelegate = presentationDelegate
        
        if let sheet = child.rootNavigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        topNavigationController.present(child.rootNavigationController, animated: true)
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
