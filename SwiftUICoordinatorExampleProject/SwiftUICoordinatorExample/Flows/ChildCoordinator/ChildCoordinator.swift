import SwiftUI

final class ChildCoordinator: FlowCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    @Published var childCoordinator: (any Coordinator)?
    @Published var navigationControllers = [NavigationController<ChildCoordinatorRoute>]()
    
    init() {
        start()
    }
    
    func destination(for route: ChildCoordinatorRoute) -> some View {
        switch route {
            case .pushed:
                ChildCoordinatorScreen()
            case .fullScreenCovered:
                ChildCoordinatorScreen()
        }
    }
    
    var rootView: some View {
        CoordinatingView(
            nc: self.rootNavigationController,
            coordinator: self
        ) {
            ChildCoordinatorScreen()
        }
        .environmentObject(self)
    }
    
    func pushNextScreen() {
        push(route: .pushed)
    }
    
    func presentNextScreen() {
        present(route: .fullScreenCovered)
    }
    
    func presentChild() {
        present(child: FirstTabCoordinator())
    }
    
    deinit {
        print("Deinit ChildCoordinator")
    }
}

