import UIKit

protocol Coordinator: CoordinatorFinishDelegate {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func addChild(_ coordinator: Coordinator)
    func removeChild(_ coordinator: Coordinator)
    
    func start()
    func finish()
}

extension Coordinator {
    
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.finishDelegate = self
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.didFinish(childCoordinator: self)
    }
    
    func didFinish(childCoordinator: Coordinator) {
        removeChild(childCoordinator)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
