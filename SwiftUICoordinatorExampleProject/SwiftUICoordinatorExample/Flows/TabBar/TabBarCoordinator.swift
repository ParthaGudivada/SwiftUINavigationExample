import SwiftUI

final class TabBarCoordinator: CompositionCoordinator {
    var childCoordinators = [any Coordinator]()
    var finishDelegate: (any CoordinatorFinishDelegate)?
    
    func start() {
        childCoordinators.append(firstTabCoordinator)
        childCoordinators.append(secondTabCoordinator)
    }
    
    let firstTabCoordinator = FirstTabCoordinator()
    let secondTabCoordinator = SecondTabCoordinator()
    
    enum Tab {
        case firstTab
        case secondTab
    }

    @Published var activeTab = Tab.firstTab
    
    var rootView: some View {
        TabBarView(coordinator: self)
    }
    
    @MainActor
    var firstTabView: some View {
        firstTabCoordinator.rootView
    }
    
    @MainActor
    var secondTabView: some View {
        secondTabCoordinator.rootView
    }
    
    deinit {
        print("Deinit TabBarCoordinator")
    }
    
    func setCurrentTab(_ tab: Tab) {
        activeTab = tab
    }
    
    func dismissAll() {
        firstTabCoordinator.dismissToRoot()
        secondTabCoordinator.dismissToRoot()
        firstTabCoordinator.popToRoot()
        secondTabCoordinator.popToRoot()
    }
}
