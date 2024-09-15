import SwiftUI

final class SecondTabCoordinator: FlowCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    @Published var childCoordinator: (any Coordinator)?
    @Published var navigationControllers = [NavigationController<SecondTabRoute>]()
    
    init() {
        start()
    }
    
    func destination(for route: SecondTabRoute) -> some View {
        switch route {
            case .pushed:
                SecondTabScreen()
        }
    }
    
    var rootView: some View {
        NavigatingView(
            nc: self.rootNavigationController,
            coordinator: self
        ) {
            SecondTabScreen()
        }
        .environmentObject(self)
    }
    
    func pushNextScreen() {
        push(route: .pushed)
    }
    
    deinit {
        print("Deinit SecondTabCoordinator")
    }
}
