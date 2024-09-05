import SwiftUI

final class AppCoordinator: ObservableObject {
    
    let tabBarCoordinator = TabBarCoordinator()
    let deeplinkCoordinator = DeeplinkCoordinator()
    
    init() {
        deeplinkCoordinator.addHandlers([
            FirstTabDeeplinkHandler(tabBarCoordinator: tabBarCoordinator),
            ChildDeeplinkHandler(tabBarCoordinator: tabBarCoordinator)
        ])
    }
}
