import SwiftUI

final class FirstTabCoordinator: Coordinator {
    
    weak var parentCoordinator: (any Coordinator)?
    @Published var childCoordinator: (any Coordinator)?
    @Published var navigationControllers = [NavigationController<FirstTabRoute>]()
    
    init() {
        start()
    }
    
    func destination(for route: FirstTabRoute) -> some View {
        switch route {
            case .pushed:
                FirstTabScreen()
            case .sheeted:
                FirstTabScreen()
        }
    }
    
    var rootView: some View {
        CoordinatingView(
            nc: self.rootNavigationController,
            coordinator: self
        ) {
            FirstTabScreen()
        }
        .environmentObject(self)
    }
    
    func pushNextScreen() {
        push(route: .pushed)
    }
    
    func presentNextScreen() {
        present(route: .sheeted)
    }
    
    func presentChild() {
        present(child: ChildCoordinator())
    }
    
    deinit {
        print("Deinit FirstTabCoordinator")
    }
}
