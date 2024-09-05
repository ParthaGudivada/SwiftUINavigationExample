import SwiftUI

final class TabBarCoordinator: ObservableObject {
    
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
    
    var firstTabView: some View {
        firstTabCoordinator.rootView
    }
    
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
