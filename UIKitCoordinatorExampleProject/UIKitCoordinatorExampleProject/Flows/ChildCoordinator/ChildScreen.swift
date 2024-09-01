import SwiftUI

struct ChildScreen: View {
    
    weak var coordinator: ChildCoordinator?
    
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
        coordinator?.pushedDepth ?? 0
    }
    private var presentedDepth: Int {
        coordinator?.presentedDepth ?? 0
    }
}
