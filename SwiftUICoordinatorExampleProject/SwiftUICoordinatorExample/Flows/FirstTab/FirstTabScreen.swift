import SwiftUI

struct FirstTabScreen: View {
    
    @EnvironmentObject var coordinator: FirstTabCoordinator
    
    var body: some View {
        CoordinatedView(
            pushedDepth: coordinator.navigationControllers.last!.navigationPath.count,
            presentedDepth: coordinator.navigationControllers.count - 1, 
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
