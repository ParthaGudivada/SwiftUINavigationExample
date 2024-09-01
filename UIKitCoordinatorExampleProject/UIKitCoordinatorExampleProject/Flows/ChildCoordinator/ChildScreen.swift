import SwiftUI

struct ChildScreen: View {
    
    weak var coordinator: ChildCoordinator!
    
    private var pushedDepth: Int {
        coordinator.topNavigationController.viewControllers.count - 1
    }
    
    private var presentedDepth: Int {
        coordinator.navigationControllers.count - 1
    }
    
    var body: some View {
        CoordinatedView(
            pushedDepth: pushedDepth,
            presentedDepth: presentedDepth,
            coordinatorTypeName: String(describing: ChildCoordinator.self),
            onPushNext: pushNext,
            onPopLast: popLast,
            onPopToRoot: popToRoot,
            onPresentNext: presentNext,
            onDismissTop: dismissTop,
            onDismissToRoot: dismissToRoot,
            onShowChild: presentChild,
            onFinish: dismissToParent
        )
    }
    func pushNext() {
        coordinator.pushNext()
    }
    func popLast() {
        coordinator.popLast()
    }
    func popToRoot() {
        coordinator.popToRoot()
    }
    func presentNext() {
        coordinator.presentNext()
    }
    func dismissTop() {
        coordinator.dismissTop()
    }
    func dismissToRoot() {
        coordinator.dismissToRoot()
    }
    func presentChild() {
        coordinator.presentChild()
    }
    func dismissToParent() {
        coordinator.dismissToParent()
    }
}
