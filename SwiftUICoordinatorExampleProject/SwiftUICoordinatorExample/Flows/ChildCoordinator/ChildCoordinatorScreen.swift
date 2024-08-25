import SwiftUI

struct ChildCoordinatorScreen: View {
    
    @EnvironmentObject var coordinator: ChildCoordinator
    
    var body: some View {
        CoordinatedScreen(
            pushedDepth: coordinator.navigationControllers.last!.navigationPath.count + 1,
            presentedDepth: coordinator.navigationControllers.count,
            coordinatorTypeName: String(describing: FirstTabCoordinator.self),
            onPushNext: { coordinator.pushNextScreen() },
            onPopLast: { coordinator.popLast() },
            onPopToRoot: { coordinator.popToRoot() },
            onPresentNext: { coordinator.presentNextScreen() },
            onDismissTop: { coordinator.dismissTop() },
            onDismissToRoot: { coordinator.dismissToRoot() },
            onPresentChild: { coordinator.presentChild() },
            onDismissAll: { coordinator.finish() }
        )
    }
}
