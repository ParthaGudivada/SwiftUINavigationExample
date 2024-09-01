import SwiftUI

struct FirstTabScreen: View {
    
    weak var coordinator: FirstTabCoordinator?
    
    var body: some View {
        CoordinatedView(
            pushedDepth: pushedDepth,
            presentedDepth: presentedDepth,
            coordinatorTypeName: String(describing: FirstTabCoordinator.self),
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
    
    private func pushNext() {
        coordinator?.pushNext()
    }
    private func popLast() {
        coordinator?.popLast()
    }
    private func popToRoot() {
        coordinator?.popToRoot()
    }
    private func presentNext() {
        coordinator?.presentNext()
    }
    private func dismissTop() {
        coordinator?.dismissTop()
    }
    private func dismissToRoot() {
        coordinator?.dismissToRoot()
    }
    private func presentChild() {
        coordinator?.presentChild()
    }
    private func dismissToParent() {
        coordinator?.dismissToParent()
    }
    private var pushedDepth: Int {
        guard let coordinator else { return 0 }
        return coordinator.topNavigationController.viewControllers.count - 1
    }
    private var presentedDepth: Int {
        guard let coordinator else { return 0 }
        return coordinator.navigationControllers.count - 1
    }
}
