import UIKit

protocol Coordinator: CoordinatorFinishDelegate {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    
    func finish() {
        finishDelegate?.didFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
